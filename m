Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23ED373BFB
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202258; cv=none; b=SFPzS9CceXXNr3L/PTeZUbumLyoTmReFCk/M3lW2Sejl5rTkMXOrv6jlniN2AvkG2lqbFuubeB2yK2bzRi6IP0WX6zNTM36miSdeiYM6DlBWGOn2MtL6cZplNujEjzYczy0LM/Dfd6ysEX4ZD7ZV8NSktBHwKRiaXrJaYlqjKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202258; c=relaxed/simple;
	bh=fhF114wACK8tjSl2ycPhpDmh1zK4XPm+CHiY1uShV7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTfOacBEC+1gX/Hq51AsCBHKQWVxUDHqcmmDv7V+GV9S7Pm6B0/OzUhLtphDFv77TE55zLj6TgKisDLSI+7IZ8uaUFi2o2LMZlEDbDEKRGUeaxB7p3jkje1EOSR65jy8TQs4T9lq814aKwirJA8k0L5VrkYr2OlTRJ9Kq8o4LIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwvtHJQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwvtHJQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CEDC19425;
	Tue, 14 Apr 2026 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776202257;
	bh=fhF114wACK8tjSl2ycPhpDmh1zK4XPm+CHiY1uShV7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TwvtHJQ/qM5QN1H2msHpRLRtQTWI1zwDaPxl8qaZqbxPKNnICp4r1FSCTwqAiMG6D
	 jsMn86rpeLRzZ/LPKV2bKoUJbCQ2uDwLL4RoZ19iWurXLOEQ2sW4DtuPgeIKJUrc5Q
	 CXNWhtAa2+pip7hQMHclOFYg6YTOjblgtxgh/dXvx6+A/Ezdd3nl5o8JPXlcRZ1KgI
	 TsVCoaDmUx98o/Dln0UM7/N4AffNC+bF5LF+MZfm0YpLIYJKyvgGv3ORQOpZAchQgo
	 B1bawogB+S2fySqccraFm6RxNKuPd3vMI/PyLzRbbKmbVHBob9mDbMeEXEF6fiIzTJ
	 f8pKKLjsv9jXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 5/5] bpf, sockmap: Take state lock for af_unix
 iter
Reply-To: sashiko@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
References: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:30:55 +0000
Message-Id: <20260414213057.61CEDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incomplete fix for Use-After-Free (UAF) in unix_stream_bpf_update_=
proto().
- [High] Spinlock held during BPF program execution leads to context violat=
ions and deadlock risks.
--

commit 059f81e7a85c481f9c7f6dd1d0ab36e935134ac8
Author: Michal Luczaj <mhal@rbox.co>

bpf, sockmap: Take state lock for af_unix iter

This commit attempts to fix a use-after-free race condition in
unix_stream_bpf_update_proto() by acquiring the unix_state_lock() inside
the bpf_iter_unix_seq_show() callback.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 590a30d3b2f70..15b48cc6e9b0c 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3737,6 +3737,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *=
seq, void *v)
>  		return 0;
> =20
>  	lock_sock(sk);
> +	unix_state_lock(sk);

[ ... ]

> @@ -3748,6 +3749,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *=
seq, void *v)
>  	prog =3D bpf_iter_get_info(&meta, false);
>  	ret =3D unix_prog_seq_show(prog, &meta, v, uid);

Does holding a spinlock during bpf program execution introduce
sleep-in-atomic or lock inversion issues?

If the bpf iterator program is loaded with BPF_F_SLEEPABLE,
bpf_iter_run_prog() explicitly calls might_fault(). Calling might_fault()
while holding a spinlock (which disables preemption) triggers a sleep in
atomic context bug.

Also, could this introduce a lock inversion risk? The bpf programs can
interact with maps or other sockets, acquiring locks like map->lock or
bh_lock_sock. Taking unix_state_lock before these locks might create an
unnatural lock hierarchy, potentially leading to deadlocks if other kernel
paths acquire these locks in the standard order.

Additionally, does this fully resolve the use-after-free in
unix_stream_bpf_update_proto()?

Since unix_stream_bpf_update_proto() is the underlying callback used
whenever an af_unix socket is inserted into a sockmap, can it be reached
independently of this iterator?

For example, could it be reached via the bpf(BPF_MAP_UPDATE_ELEM) syscall,
or when a bpf program updates the map using a different af_unix socket than
the one being iterated? In those cases, unix_state_lock(sk) would not be
held, leaving the use-after-free unresolved.

Should the lock be acquired directly inside unix_stream_bpf_update_proto()
instead?

>  unlock:
> +	unix_state_unlock(sk);
>  	release_sock(sk);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-unix-proto=
-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co?part=3D5
