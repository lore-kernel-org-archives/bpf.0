Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6F3ED5B6;
	Mon, 31 Aug 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177904; cv=none; b=dxYyPWjd0asTI19XAMC7sV+zHi1uL/fSbr3dn2jQfQt3gyzjDUSM33tvotcYbozuAWNb4nRQL/PTqghAdc/bckYPX1cSwry/NSL3Xk52ai7mStUSxMgvE+NbNJ4NeOljLci283BshSwum3F8dZ9+l2VYkXp7zdXAdFrw24Sga1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177904; c=relaxed/simple;
	bh=D+aRmPS7eULHVWFJU2yaBVIeZhyBobHA6YV0Fu327WA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oWAy0irEntwhPpg7YyLJn0rY9DRm4exe8HEDgGxBA7TPErmaPSwlRn63rxHpQKc4uXzpvQc1o8JM0BfWSvEGHxUsW+zI+jt18RiEG9BAoJ/4fH8O8T76F6PIYOiw6uujKliMyIrQHGhpDNLU3VMJNPMkiE1B4Y3PrJsVtXolpMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIxgB8VG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIxgB8VG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2471F000E9;
	Mon, 31 Aug 2026 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177902;
	bh=UxyOGkkYP+fmVU/277QcNz3Ra6vbEkFHnsjgcDx5R10=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gIxgB8VGhUMitcDtGg8DonCDcEKBa3qA9p7eTqYDFA2j//XIVuoAXRHbEzFOCtB+z
	 6Z9AkfkKklpHcNE/Kmuu6IXGOM28/2/SgpU8XbrRnLhZljJjU80mLuHspPUqaSNIBj
	 c3uchmio+Ibfs6F5ojHK+nc9X+gKp7fZxpG026lryunkWEr4YVktJnDhyUNtOsdgbJ
	 FZY7g3iHqjsfBFjcPVmLqZHC8jt3zOrJYhQatV5D39kx2ESfnlE7mQq0Cewp96BfSF
	 DE1cmlU6fAsdXeGtzPn+J8cvNXTEW6Db/GM8/lEy/zXrJp3Dt5c+kmbxECU4CkmL7J
	 ucJ6+Td4aI4hw==
Content-Type: multipart/mixed; boundary="===============4050481947324525488=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ed4c84cc7d723627f10b9b5d1dafb9b72d3e0bcff6db149d7605f5d9ad8c7b1@mail.kernel.org>
In-Reply-To: <20260831110314.150870-2-jiayuan.chen@linux.dev>
References: <20260831110314.150870-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v3 1/5] bpf: Reject key-less BTF for hash maps
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:05:01 +0000 (UTC)

--===============4050481947324525488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> map_check_btf() allows a key-less BTF (btf_key_type_id == 0) only for
> maps that have a ->map_check_btf callback, and leaves the actual
> decision to that callback. Hash maps used to have no ->map_check_btf,
> so a key-less BTF was rejected outright.
>
> That changed when htab and rhtab gained a ->map_check_btf to register a
> dtor - htab in commit 1df97a7453ee ("bpf: Register dtor for freeing
> special fields") and rhtab in commit 6905f8601298 ("bpf: Allow special
> fields in resizable hashtab"). Neither looks at the key, so a key-less
> hash map now passes map_check_btf() and gets created. Reading it back
> through bpffs feeds the key type_id 0 into btf_type_seq_show();
> btf_type_by_id() returns the void type, kind_ops[BTF_KIND_UNKN] is NULL,
> and btf_type_show() dereferences it:
>
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
> Call Trace:
>  <TASK>
>  btf_type_seq_show_flags+0xca/0x120 kernel/bpf/btf.c:8250
>  htab_map_seq_show_elem+0x12e/0x350 kernel/bpf/hashtab.c:1669
>  map_seq_show+0x13d/0x1e0 kernel/bpf/inode.c:293
>  seq_read_iter+0x93f/0x1270 fs/seq_file.c:196
>  seq_read+0x344/0x4d0 fs/seq_file.c:163
>  vfs_read+0x1e4/0xb40 fs/read_write.c:572
>  __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>

The call trace appears to be edited from the original syzbot report.
The original report (6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com)
includes these additional frames between map_seq_show and seq_read_iter:

  traverse.part.0.constprop.0+0x107/0x650 fs/seq_file.c:112
  traverse fs/seq_file.c:99 [inline]

and also includes the inline frames for the pread64 syscall path:

  ksys_pread64 fs/read_write.c:760 [inline]
  __do_sys_pread64 fs/read_write.c:769 [inline]
  __se_sys_pread64 fs/read_write.c:766 [inline]

The trace shows the crash happened during seq_file traverse() (the pread64
offset walk) rather than a plain forward read. Could the commit message
either restore these frames or mark the trace as trimmed?

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d8db1cebc1936..855cab4e1bd7d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -530,6 +530,10 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>
> +	/* Hash maps have no use for a key-less BTF. */
> +	if (btf_type_is_void(key_type))
> +		return -EINVAL;
> +
>  	if (htab_is_prealloc(htab))
>  		return 0;
>  	/*
> @@ -3111,6 +3115,10 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  {
>  	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>
> +	/* Hash maps have no use for a key-less BTF. */
> +	if (btf_type_is_void(key_type))
> +		return -EINVAL;
> +
>  	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
>  }
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33385673160
--===============4050481947324525488==--
