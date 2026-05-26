Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C03C73D1
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834288; cv=none; b=Z7cCA5B7qsn8bMYGRdzcz4HeZZ18M7T25gfFFaf9eiq0rPiy8gY4rtEvPkU8CqbmYlde4pwW0ARU8Y4Tl03GtYNUM6yCWIpYMqS6Xo551rbABgSo9SesZEoNpdwXxpCUNBaxf5el1xf/iUnfa+yWV76cGbCm/yGl8K6CYgwG4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834288; c=relaxed/simple;
	bh=GxbQ8NIk4mgl61gh8KFDsnH5jMKPJyjLI5wJFoJcLLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ird4Md38TKmT40sYnKle55xzkUiCvtC0tHvcJFXO35jPEY3u0vpVc8wnufQVzDUjfIXXGExd/FcXl8IAhzaoVEV2lGDGZY8tMXSdVQJYMpLb9/f2PUVbqEFlPhpFRZK4wVOcHLEMRATYN6bMfD4nd9hFbYnMVARmqSjZMqhHzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MZq1bC5t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MZq1bC5t"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso4161135a12.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779834285; x=1780439085; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZg3/Nrp/XSikTx+0njY7ovlfnqPSA3h4CFSyjzLU5Y=;
        b=MZq1bC5tNXiGp3TbIA/cWPITDW7PrEBMxLE7q4RVQ3mjdRpAVHQtt9zxUgx2OkPsvo
         XSjeqcPHo3Qwkszs7uUPxfCEuMykpHX0hbfxP82EqAWmQJIYsBEFY4HM5c44LptDLb56
         23muriERM/yN8y9I5HfCBd8vsiev6txgivViGRntYepgXbIucmSeihpJsN7uEH/rxqHs
         Wpj3p4eSv8cvx0SFv/T10SteGyGLZVVnquZ59NKfUWuxJisW3b+WLgztZofvWLNy8OZg
         lwy+RAbU/rYgGGXBECIJ5myD1l68YgTqDJJKU6dxTMYl/pILFMNAqBhxw6TLH5zIx3nB
         0YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779834285; x=1780439085;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZg3/Nrp/XSikTx+0njY7ovlfnqPSA3h4CFSyjzLU5Y=;
        b=kAmO1vDR7+HdC2wQgepcbD6xO0tc9XKN94hWo1b+noF2FxYGbniZTb/O3/kJONEuYi
         XhYIC36Zce03v1Ov2/OrKd8+tl82eDKV6QfMlyirTf3aeRMFX84EoXH+CwaKwYQ2QF5i
         yQPEkIMAUl6kmf+lY2l6LZmi2IvO2Z6BPeu+iS5lr10xV4B/MIVpiZKOFtJV0mBdaqMM
         Jzi1uhhRJa4o3ZL5Y1Lr3nz9SGHsw2sJJRntJ6tnRaOpnEw1ePHscxTCj4R+INjCSh8e
         g7ts4+DJbSZGnjHct+7HwzSNMCKPrVFvkaaKOUACvWgtBRuwCmZzyr3CiDw3D4VNq4L5
         zoLg==
X-Forwarded-Encrypted: i=1; AFNElJ/vVUQxA7A/Vi6QtafaFGDWEFBniYYv6F1H3uUTD8ZQ5k1/2n+bRG60XSINWIt24gTGx70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHESGVFo79jI1mpCyrguVfOBsAj3MznP3p0eGhW9v0N/xta+A
	/N62hnxk7Q59KgG4COXAVsT7FUMGW9f8+D8kgrSVZ5SlrR4Jqth46zCuSFWwPUzGiX8=
X-Gm-Gg: Acq92OGA0onrarzNYj2yDYZlnFLe5xp4EODbZZQUPcaW7C+qe07t81PKRD6di2u0HGb
	uIJTq6r1uZOG5kLa/a0TZ9xqi1bYvZVvh65POEVIjFET0CaZGsUdg+jotCjHeB3uslOl83TTLze
	1onA1ze17GeRqu99s4nUPhBRKSZc7eRFz7qB1YHnMwiDoHRMpbLmG85KWvqMn0S+eMtmonEQ8E5
	eL+usPWUBrPya+7CnQ2e2uIl7AbRb9JfD3IcAHI6NFTBMdZZHUtnZror6jX7jvPjlzN4T1XGxwx
	s7cVXXNTvho6vSxUd1G6r4mni9ssmFQsDSzS/P94UgdCOu9+TW6+J3VB7C3nGRULdb23HlEPkra
	MAIjuUFBRgfNlgAKJOel7CP34z2FaSCVdHJ/wK5yi5GWyjeymoWrFbs6ehDKIlFLRiIEPoYON25
	JyX5M9+GfhOGx/eZ3vbp3mfMDy
X-Received: by 2002:a05:6a20:2449:b0:398:b346:b13 with SMTP id adf61e73a8af0-3b328cfe3ffmr19991485637.16.1779834285148;
        Tue, 26 May 2026 15:24:45 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028fe99sm11268978a12.4.2026.05.26.15.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 15:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 18:24:44 -0400
Message-Id: <DISYLID6QGFY.1HTQOMHVLTRWS@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <martin.lau@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kees@kernel.org>,
 <joel.granados@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
Subject: Re: [PATCH 2/2] bpf: cgroup: Use kvfree instead of kfree in
 __cgroup_bpf_run_filter_sysctl
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260526131035.1312864-1-dawei.feng@seu.edu.cn>
 <20260526131035.1312864-3-dawei.feng@seu.edu.cn>
In-Reply-To: <20260526131035.1312864-3-dawei.feng@seu.edu.cn>

On Tue May 26, 2026 at 9:10 AM EDT, Dawei Feng wrote:
> proc_sys_call_handler() allocates its temporary sysctl buffer with
> kvzalloc() and passes it to __cgroup_bpf_run_filter_sysctl(). Since
> kvzalloc() may fall back to vmalloc() for large allocations, freeing
> that buffer with kfree() is wrong and can corrupt memory.
>
> Use kvfree() to safely handle both kmalloc and kvzalloc()/vmalloc
> allocations.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
>
> Reproduced the bug based on v7.1-rc4 in a QEMU x86_64 guest booted with
> KASAN and CONFIG_FAILSLAB enabled. The reproducer confines failslab
> injections to the proc_sys_call_handler() range, uses
> stacktrace-depth=3D32, and injects fail-nth=3D1 while writing 8191 bytes =
to
> /proc/sys/kernel/domainname from a task in the target cgroup. On the
> patch1-only kernel, fail-nth=3D1 triggered the fault:
>
>   BUG: unable to handle page fault for address: ffffeb0200024d48
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000  SMP KASAN NOPTI
>   CPU: 2 UID: 0 PID: 209 Comm: repro_proc_sys_ Not tainted 7.1.0-rc4-0068=
6-g97625979a5d4  PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01=
/2014
>   RIP: 0010:kfree+0x6e/0x510
>   Code: 80 48 01 ef 0f 82 ae 04 00 00 48 c7 c0 00 00 00 80 48 2b 05 04 1b=
 23 04 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d e2 1a 23 04 <4c> 8b 57 08 =
4c 89 d0 83 e0 01 48 83 e8 01 49 09 c2 49 >
>   RSP: 0018:ffff888108de7ab8 EFLAGS: 00010282
>   RAX: 0000777f80000000 RBX: ffff88815af398c0 RCX: 0000000000000080
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffeb0200024d40
>   RBP: ffffc90000935000 R08: 0000000000000001 R09: 0000000000000001
>   R10: ffffffff86b4b297 R11: 0000000000000000 R12: ffffffff819b71fd
>   R13: 0000000000000001 R14: ffff888108de7cc0 R15: 0000000000000000
>   FS:  00007f8988cc2b80(0000) GS:ffff8881d3256000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffeb0200024d48 CR3: 0000000101d6b000 CR4: 0000000000350ef0
>   Call Trace:
>    <TASK>
>    ? __cgroup_bpf_run_filter_sysctl+0x626/0xc30
>    __cgroup_bpf_run_filter_sysctl+0x74d/0xc30
>    ? __pfx___cgroup_bpf_run_filter_sysctl+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? __kvmalloc_node_noprof+0x345/0x870
>    ? proc_sys_call_handler+0x250/0x480
>    ? srso_return_thunk+0x5/0x5f
>    proc_sys_call_handler+0x3a2/0x480
>    ? __pfx_proc_sys_call_handler+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? selinux_file_permission+0x39f/0x500
>    ? srso_return_thunk+0x5/0x5f
>    ? lock_is_held_type+0x9e/0x120
>    vfs_write+0x98e/0x1000
>    ? srso_return_thunk+0x5/0x5f
>    ? kmem_cache_free+0x308/0x550
>    ? __pfx_vfs_write+0x10/0x10
>    ? __pfx_do_sys_openat2+0x10/0x10
>    ksys_write+0xf2/0x1d0
>    ? __pfx_ksys_write+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? trace_irq_enable.constprop.0+0x110/0x140
>    do_syscall_64+0x115/0x690
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    RIP: 0033:0x7f8988dd8907
>    Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1=
e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8  01 00 00 00 0f 05 <48> 3d 00 f=
0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 >
>    RSP: 002b:00007fff4069b878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>    RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8988dd8907
>    RDX: 0000000000001fff RSI: 0000564f97ef46b0 RDI: 0000000000000005
>    RBP: 0000564f97ef46b0 R08: 0000000000000000 R09: 0000564f97ef46b0
>    R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
>    R13: 0000000000001fff R14: 0000000000000005 R15: 0000000000000001
>    </TASK>
> With this fix applied, rerunning the reproducer with the same
> fail-nth=3D1 setup yields no corresponding Oops reports.
>
> Fixes: 4508943794ef ("proc: use kvzalloc for our kernel buffer")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8715a014c21d..f4eefdacd453 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1936,7 +1936,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
>  	kfree(ctx.cur_val);
> =20
>  	if (!ret && ctx.new_updated) {
> -		kfree(*buf);
> +		kvfree(*buf);
>  		*buf =3D ctx.new_val;
>  		*pcount =3D ctx.new_len;
>  	} else {

