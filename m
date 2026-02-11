Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785E1DE3DB
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777741; cv=pass; b=X9Fvmu86HRqZzNmSxBa8Tf3e4BfyX5KZ6obiuWOIMr0wLYzoyylBIpHjTZ7a6Dczf5fcM2sVNmgBbfdaS9JMjbCCIAKV+Nsczxy92tiVTxdpD7BiAqIBLplI/eRa3PvdizpDsPk1MXVuaAdjhiNG1b/l26YqsJtLVSIoGdhuaoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777741; c=relaxed/simple;
	bh=ghvaUWhu3nHPCWZnEs/ZaH8SfzvE/QaN2dTNxhabSTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReN7e17eutnLZNbmQfJFw+XP1uB24RyA5RjOki3KAo4s5ymvuAIXZyRazR2bTFPN1KJy1KREgGMLmXClEvunoQ+RnEYXZMauCHtvJQxOq1HbRUhWsOEnNyIjPyn2XZ4p7iS0ScF1txnBNwcfN28kAbsPcELTWaS2K03CX3qKGL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgY5g/Fn; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgY5g/Fn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so92035575e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:42:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770777738; cv=none;
        d=google.com; s=arc-20240605;
        b=FIxGhIpymgZaaPghHXQ0gVH4n6nCM9jmNxGQ5mf7r6vOljzhg0LNkRW5/IOpJY+LjY
         UKK5FxAKDeh2bxULaOpa5DpaKYFpFlHDyZrcf766kAkUOj6zX7I5WbQGodDCWSQXOVim
         m8Ug1lYQU0opcHpH6KFEljHYMsSsDzLzC9SQ9FlR2mDcKjhrmeAN9svGxJ8djDmkF6iz
         nYvgqilenODLi//8YPc3ZANHihsquZeklte0oVO84zSZMmxzQOWk9ZJidfiaCiNs1c4I
         rL2sb9YLRE03jqzu6maz/xMvV/mNv7k5jkIzDHjijAn3GP99xrPC3Llna0ikL28/8zlo
         xSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y8HMEyTXTUp1aeCNqOP4gzVuageqRuV/Vld+w3SyAyk=;
        fh=cYWxAO4hEA81svD5X/DiiNB7a/xE2yZ32mprOvFjECI=;
        b=AS04gnAum0qYn8nh7r5JjjTShQiKL8xhi57m3cFOKO9Wu+u/RWxurLerUFpyumS1KR
         vrIq6bIlowVA5pN47pF3aUx/qXN6yf06+03qVOV8U98jusz67qxQgoagyk1NvnX3bOcu
         dqzaKV5ZtuNI8OL+t2UMyK0fqAAzui33KBqjCLZ+FV03GXhalEuYQIycuIi98cQFothn
         Hm9F5nNHC+JN6pye1Kb4lcIiRCXAD1iYrAB+EDmJK2M8i7/B6NVAZ+MaW1CXFQy2P9zU
         kteOvikr/aH7K5OE7eacOg0PgVjt+8TmugXXTw7yGITU9MiVJZCQbxGOj7eYqYbwasUD
         U5fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770777738; x=1771382538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8HMEyTXTUp1aeCNqOP4gzVuageqRuV/Vld+w3SyAyk=;
        b=IgY5g/Fnz3HUlQYDnjyJxsHAkXd8wRzcsBshTSk8YsgdMa/FMhFSfTuahloV4JFCdX
         OYD7VkKRnsxzbiGANWl5PuGiPmW1lffzHZp2NSm//JHtRIiOZvzr6XkcIVgmezz2Rmq0
         sMoMbKx/NjngpRDGzX2vRV8/ZSscTGyHOKl/z+gfp3elTv46mKVKC12bsaJEHpv79sLi
         hDn40W0ytxqyOQ2FgBVurq6VH5KnwEC6xHP9sZqlshxGt8kim5zG6EzTllKmtIzFduNk
         mRlHPi06hmIXXIIMNRDyQyH/FHRA4XC6Z7ZjSRLZU1gVbwSfy7t/vzdkthGq1v5VXUMR
         3R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770777738; x=1771382538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8HMEyTXTUp1aeCNqOP4gzVuageqRuV/Vld+w3SyAyk=;
        b=ptfX3suwhUPEyAOcEGIh986uLrEgLTj+Cz86obFcqs8+14HnBWBcBqbD/qdXBclO9a
         kAeXQ4MZlvTE6fAElaAtp0CRmq4QpndrG3HbpBWmsANVj5IuNCtdMtc29i6ui+RYwKYq
         tkaB5+r2iJuy4eslnxlyrnYDKagYrzXNI0KFhXbaCSKmXSV9o7v+awVYFzrRNgeE2IsV
         F4B5XP/g7CAmt8vIl4yasRTeqjdogxxvfXNvtWcFoTep/cwlLfDtb5PiB4StZBj7kBLn
         tW+HXckUXHi1HZb9b0L57iser1D73NPg+xuTncLBBlCgNhnxX9IYkNm43jKGOKvffFlV
         3lTg==
X-Gm-Message-State: AOJu0YyaiBc/okjxPAD5IyHn7g+wV64tzlv3/Jc1eQsxvIhmqzEMLnkk
	BbzkfjqnRBsdlekizNtkc0QrS2gsPnkQqrsH25NZDiPmqHu/y7zLJk5oXBslZBHzJZ/QDJsIGn+
	uTrP23WrLhz2onk3XapWLIwikyzK/1kE=
X-Gm-Gg: AZuq6aK7zacT/+WdRqZ44nNJ0jljA2FZXwxUc/En+AALJotW0o3vpUHx7ZUXw86WvfQ
	9a5Gf9QmS+UR6d7aFmeh5O5KQq4chn4fiXNzNMPV1/N5wLXmJbGawN7Vt4JDSZWXqnU6OiL8ABO
	3E7t5RJoAth7e/jZJnNOGLVhHW9U3LezY/QqzFOGQFq/cueZbbVVEzVWmAMIRrlNAnZpEvOme3Z
	dJTR+vhLCaJnWC3yCRO4a5YBxML6JuQvKODDumiMRxh7A7dZKdrC9bxe+4UZl14SK81vG2A2xL8
	tWQyhQGAxeYCBWyfIRRFzk/6MijTwzZR3pT32Rj6OVr1y1PmjmkBOW4lDZWnNWKpujUXgbXVx9q
	/jHIA3209Vy3H5Q/R6VsQLFjzeQ==
X-Received: by 2002:a05:600c:8b0e:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4835081ec9cmr59862785e9.20.1770777737749; Tue, 10 Feb 2026
 18:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770736390.git.vmalik@redhat.com>
In-Reply-To: <cover.1770736390.git.vmalik@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 18:42:06 -0800
X-Gm-Features: AZwV_Qic-lPnHl1msGyqYwMovd1nrmc7fuVqIJFcfgAPbJaYlJa2spHbTbBzl4U
Message-ID: <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jordan Rome <linux@jordanrome.com>, 
	Qais Yousef <qyousef@layalina.io>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 7:14=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Some enterprise kernels (such as RHEL) do not enable error injection via
> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
> When running test_progs on such kernels, a lot of test cases fail since
> they use sleepable fentry or fmod_ret program types which require error
> injection to be enabled. While it is possible to skip these via custom
> DENYLIST, some test_progs are not properly split into subtests and
> therefore must be entirely skipped.

Something is wrong.
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
-int do_probe_read(void *ctx)
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int probe_read(void *ctx)
 {
        char buf[8];

@@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
        return 0;
 }

-SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
-int do_copy_from_user(void *ctx)
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")

sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.
While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.

Both fentry and fentry.s should work fine on sys_nanosleep.
fmod_ret is also completely independent of these two flags.

Please root cause it instead of hacking the tests.

pw-bot: cr
