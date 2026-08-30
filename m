Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA112F1FC3;
	Sun, 30 Aug 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078902; cv=none; b=q0osMwmpETi2kRYTf2Mr2OH7+dPfpRH15XWjACkzEoARm43YI4yPyUwfGlN1ZMOO/4kbQ70EGIhazu/Da4ZgSoQHotwB/myLdaiyHyTVxj6z12ZtkcRk3M3YSXpuxHaYWqf0HGZzzBYlnsNay5/OD4zhnrLQt3v3SP8741qmGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078902; c=relaxed/simple;
	bh=WpmfR6ALCJYuuF4+WjNOYYis5nKaxwWmhtWsRCanX0g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mYOS4JM7d4KdlDFyUFG5s0WZ60o5gb5/KyQSHhF0cB3AwyVuOIxYyy02LrwhMpiYsrYvyl8jL/+D/mWt6kprmI6yGRM06cCwvRfJH/le00HuUmqT83D6pj1Kec4PXwINesWkogkWDK0XDOJvMy+bYaOhJ/vSf3iYqDenP3O/PgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABxtDlHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABxtDlHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447AB1F000E9;
	Sun, 30 Aug 2026 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788078900;
	bh=ioCazvgparxIGeT5lFnIkmOmte8GA4wNeKGQVBX/4MI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ABxtDlHD0XSicySjDOWqisJvqfJQz+i8nVD+sMXoPRZlbIU/uv5b4zzlH4UGzgWhI
	 v4kNCh8uS54a49R8t2Wsm1doZN42lW1sAQiNph2NHR8UB+vAG4EgpGjBEbwJEYRBgu
	 Rw1DNb6WE7M0Zb8KYTImv3v3MIx5HqlNWmGxb7bJkU6DAuao727ReqYzXsBojbJdK9
	 t3WbKu3lTP5VsC/XOmx7hAHGJrzgLxDkw4GzPFYE7UGc+KESszAyHL2HKZQN6hR2W1
	 gYhmHP1MB/7TfzRtpMcRi5aVOUN/fjo+wRzjdMIbwqwcpMXIV0G71HMMSOIDR3yiV0
	 2VTmP4jrSdXYg==
Content-Type: multipart/mixed; boundary="===============1891050457746649038=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d6bd8635809173a29c38636403f6f98d848d5f408b44639478b266a8cc65437@mail.kernel.org>
In-Reply-To: <20260830073242.148092-2-jiayuan.chen@linux.dev>
References: <20260830073242.148092-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 1/4] bpf: Reject key-less BTF for hash maps
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 08:35:00 +0000 (UTC)

--===============1891050457746649038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> map_check_btf() allows a key-less BTF (btf_key_type_id == 0) only for
> maps that have a ->map_check_btf callback, and leaves the actual
> decision to that callback. Hash maps used to have no ->map_check_btf,
> so a key-less BTF was rejected outright.
>
> Since commit 1df97a7453ee ("bpf: Register dtor for freeing special
> fields") htab and rhtab got a ->map_check_btf to register a dtor, but
> it does not look at the key, so a key-less hash map now passes
> map_check_btf() and gets created.

Is this attribution accurate? Commit 1df97a7453ee did add
htab_map_check_btf() to the four htab ops structs (htab_map_ops,
htab_lru_map_ops, htab_percpu_map_ops, htab_lru_percpu_map_ops), but
BPF_MAP_TYPE_RHASH did not exist at that commit.

The rhtab regression was introduced three months later by the second
Fixes: commit 6905f8601298 ("bpf: Allow special fields in resizable
hashtab"), which added rhtab_map_check_btf() and rhtab_map_ops for the
first time.

Could the commit message distinguish which regression each Fixes: tag
addresses? As written, the sentence attributes both regressions to
1df97a7453ee.

> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> RIP: 0010:btf_type_show (kernel/bpf/btf.c:8251)
> Call Trace:
>  <TASK>
>  btf_type_seq_show_flags (kernel/bpf/btf.c:8269)
>  btf_type_seq_show (kernel/bpf/btf.c:8277)
>  htab_map_seq_show_elem (kernel/bpf/hashtab.c:1669)
>  map_seq_show (kernel/bpf/inode.c:293)
>  seq_read_iter (fs/seq_file.c:273)
>  seq_read (fs/seq_file.c:163)
>  vfs_read (fs/read_write.c:572)
>  ksys_read (fs/read_write.c:716)
>  __x64_sys_read (fs/read_write.c:725)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>

Does this match the syzbot report? Looking at the actual report at the
Closes: link, several details differ from what was quoted:

The syscall in the report was pread64:
  ksys_pread64 [inline]
  __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769

But the quoted trace shows read (ksys_read, __x64_sys_read).

The report shows traverse() frames that are missing here:
  traverse.part.0 fs/seq_file.c:112
  traverse fs/seq_file.c:99 [inline]
  seq_read_iter+0x93f/0x1270 fs/seq_file.c:196

And seq_read_iter's line number is 196 in the report, not 273.

There is an extra btf_type_seq_show frame inserted here that is not in
the report.

The btf.c line numbers are shifted by +19: the report shows
btf_type_show at 8232, btf_type_seq_show_flags at 8250, and
btf_type_seq_show at 8258, but the quoted trace adds 19 to each.

Should the crash trace be quoted verbatim from the syzbot report rather
than edited?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33300136294
--===============1891050457746649038==--
