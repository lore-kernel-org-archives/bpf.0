Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556535675B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509341; cv=none; b=iQs+Q+ekv/1i0JzwJw9h4+Uw5wcPInekWtngTjzx8MxXi1yL/3NCrFCRsFNP/CHOy09VUU/Cgp5+P4/+W4PU/Cdm7CsJUhbv9Rb9eXT26huGLoJOQfgTUozpuLVxmeFBY4KT5tEifWDfpWAW6FcY+vtBwcx2oa4RhtQ2lIkwjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509341; c=relaxed/simple;
	bh=Lyk7HobqBVqi/w+Irgcl8BdCJlMtUPadfQyz/3I74Bc=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=sVXAYhbUDaU994Igvn3yha5ZWICdndGyjkJne4eXCV2+WoPligkG/leVN3QvhAUGj1EA8Fn+yIFCuCttia8zZpDrpsMJcS8/Cceu2wzBTBhj8x70m6NW96wW267wA+UGOO5hb/jSuSvimAXeg4Og79lFqbo+v75E7K5WRuLoWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6XUziGw; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6XUziGw"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c54b82e936so50749137.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509339; x=1783114139; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jj7jttCu024jqSdUgB4OQ1Q1Ewlj7fZXOsyZrmCJlFo=;
        b=i6XUziGwOR1VunsZOeR72At7vm6bdJ48YbNJByhJw9+meOxR1PrxguUzVQUARmoumj
         ht93YaFO15yAaM72QBxQhIVBaBDCNpJkx47pu/iHwb2FjMrquy6rEogn+wLssbbc4Sdq
         zn1ztkuGGTt7G4MsXd4GT7a1QBt+uOmJP7/4ZctInKXpHsVWJqrtqhdOzCYq4YoEDG6U
         HReH3sTUtJu4c2tCfaeui+iboINUDgX8eKSvuP9o7pTgL1vvNNqpx8+VVuOCJZ7ooZXu
         ms8pdnBpXdlgjWBM6uYcSA3z8K9ehXa1C1SPwz17mVPqJBiJqfjwvWkabyUNyh9NSpcE
         pwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509339; x=1783114139;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jj7jttCu024jqSdUgB4OQ1Q1Ewlj7fZXOsyZrmCJlFo=;
        b=mDv+m8jI4mXhaH8tjPZil819tl1xQYhmx+FG1wNKG9vuOOmIZWOQTVzBDPdOAeBmkl
         Bs5F3wDPK+9W92oQOm8UMFIDPQpaLVTDQnP2UU1t2utqOtWmVBwsJ7VZF43iSD5wPXLu
         IMsp0X6oEOAL4SLN8z0Rwv/3CB4B509D2ZExmFLzVIm6isWYCs8yNycizOGdU78v++R5
         DWpurxrRheqQg9PVwBXOza+yF19ciryMJ6RZrssVTb5u6jK9uvK8NJZ1iAB0rENcyCPQ
         5etx2DiHHVBcDy49mTlIjZm0HSR5JE+Z0zFknrA8oA5da7lP2FQKGhrWmKKO+psxscMT
         +/gw==
X-Forwarded-Encrypted: i=1; AHgh+RqqJ77lYlMVp3I7sBehVhqoV6C0+jX0fl+NhTPZBprwKmfyJk3aYpKVNi+d2ZFvWkjHnHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqjWgwZgh3NAHVQpteyYHizzSWEHLz0Xt/BKoXhIMBTI0ePI5
	tx4L8+rmP+tVSRPEPCoQ1fW0l0sdG0/s4HzdQ6AZyX+09/Bqa3DqnRbY
X-Gm-Gg: AfdE7cmkv9wb82PLTWICoqPYw+zcXO+a7Q4iNk/CRlbMib7o16O75wwX82eIfSbKy/X
	NrXXgWmv821+kADKbx/EOPGgv8XlSKSN9UfrMchNKpdbhizBGlHqvzmdhk8e3pO2fInITVt48pD
	YL53HFUNJqddKJgpYuFdiFrb6aIc/C3szh1d2ZAsaK61tLaAnLJ6daxSCfoHsVO00A7Rn/HblcS
	A+Z1wV0O+GzZodzOZN2hkhOORkqzLjZhqbYOxmsxQ9AC4+btVHwMXoPCJbZ99T1DhIBQ89c7ghd
	LJBaIiWv9PSN1YqrXlKmTls/ny1Iiw3svhpRZd4Tqw3TNUTbIk44hEL96Y+iy7BDAZz7pyXXRPi
	of0QslAF5APBxPwcX3vlxcIcODDG5Ec5XPD9NvjvWo8IDgf+MK3lyj4gfprGYwqQQ/UQ3eJVq/m
	Xsvt0lDceyU7V1qgpUsQOG9md88w1Yw6UkYTX7uU6OfBWgJTTDZI52tkB8DrCTq1WI5vTB2z40O
	MiIBw+JPAeGWzGSJrl6fP0=
X-Received: by 2002:a05:6102:424c:b0:6c1:6ef9:db9d with SMTP id ada2fe7eead31-734360a22a8mr1483142137.3.1782509339113;
        Fri, 26 Jun 2026 14:28:59 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd7908a922sm1842426e0c.10.2026.06.26.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:28:58 -0700 (PDT)
Message-ID: <6a3eef1a.516c2524.21c3a2.afcd@mx.google.com>
Date: Fri, 26 Jun 2026 14:28:58 -0700 (PDT)
Subject: WARNING in bpf_check
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=1k9D2rcoA6Ta2EKqEXXLkEqia9y0Pezfk>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

------------[ cut here ]------------
verifier bug: error during ctx access conversion (1)
WARNING: kernel/bpf/verifier.c:22670 at convert_ctx_accesses kernel/bpf/verifier.c:22670 [inline], CPU#0: syz.5.97/11999
WARNING: kernel/bpf/verifier.c:22670 at bpf_check+0x11a77/0x1c9a0 kernel/bpf/verifier.c:26032, CPU#0: syz.5.97/11999
Modules linked in:
CPU: 0 UID: 0 PID: 11999 Comm: syz.5.97 Not tainted 7.0.0-rc1 #1 PREEMPT_{RT,(full)} 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:convert_ctx_accesses kernel/bpf/verifier.c:22670 [inline]
RIP: 0010:bpf_check+0x11a79/0x1c9a0 kernel/bpf/verifier.c:26032
Code: 84 a7 00 00 41 88 1e 83 7c 24 08 00 0f 84 8e 00 00 00 e8 0a 1e de ff e9 fc 40 00 00 e8 00 1e de ff 48 8d 3d f9 87 ef 0f 89 de <67> 48 0f b9 3a 48 8b bc 24 78 01 00 00 48 c7 c6 c0 7f 78 8c 89 da
RSP: 0018:ffffc9000c19f640 EFLAGS: 00010283
RAX: ffffffff81bb16f0 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9000f4d1000 RSI: 0000000000000001 RDI: ffffffff91aa9ef0
RBP: ffffc9000c19fb30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000040 R12: 0000000000000004
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000002
FS:  00007f01a33266c0(0000) GS:ffff88809826b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01a5347dac CR3: 000000004a65a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bpf_prog_load+0x13be/0x19e0 kernel/bpf/syscall.c:3089
 __sys_bpf+0x5c8/0x8a0 kernel/bpf/syscall.c:6228
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x81/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0x760 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f01a50d3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01a3326018 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f01a5345fa0 RCX: 00007f01a50d3b6d
RDX: 0000000000000080 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f01a5177c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01a5346038 R14: 00007f01a5345fa0 R15: 00007ffe12d33220
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
   1:	00 00                	add    %al,(%rax)
   3:	41 88 1e             	mov    %bl,(%r14)
   6:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
   b:	0f 84 8e 00 00 00    	je     0x9f
  11:	e8 0a 1e de ff       	call   0xffde1e20
  16:	e9 fc 40 00 00       	jmp    0x4117
  1b:	e8 00 1e de ff       	call   0xffde1e20
  20:	48 8d 3d f9 87 ef 0f 	lea    0xfef87f9(%rip),%rdi        # 0xfef8820
  27:	89 de                	mov    %ebx,%esi
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	48 8b bc 24 78 01 00 	mov    0x178(%rsp),%rdi
  35:	00
  36:	48 c7 c6 c0 7f 78 8c 	mov    $0xffffffff8c787fc0,%rsi
  3d:	89 da                	mov    %ebx,%edx

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

Modules linked in:
CPU: 0 UID: 0 PID: 11999 Comm: syz.5.97 Not tainted 7.0.0-rc1 #1 PREEMPT_{RT,(full)} 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:bpf_check+0x11a79/0x1c9a0
Code: 84 a7 00 00 41 88 1e 83 7c 24 08 00 0f 84 8e 00 00 00 e8 0a 1e de ff e9 fc 40 00 00 e8 00 1e de ff 48 8d 3d f9 87 ef 0f 89 de <67> 48 0f b9 3a 48 8b bc 24 78 01 00 00 48 c7 c6 c0 7f 78 8c 89 da
RSP: 0018:ffffc9000c19f640 EFLAGS: 00010283
RAX: ffffffff81bb16f0 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9000f4d1000 RSI: 0000000000000001 RDI: ffffffff91aa9ef0
RBP: ffffc9000c19fb30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000040 R12: 0000000000000004
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000002
FS:  00007f01a33266c0(0000) GS:ffff88809826b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01a5347dac CR3: 000000004a65a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bpf_prog_load+0x13be/0x19e0
 __sys_bpf+0x5c8/0x8a0
 __x64_sys_bpf+0x81/0x90
 do_syscall_64+0x160/0x760
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f01a50d3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01a3326018 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f01a5345fa0 RCX: 00007f01a50d3b6d
RDX: 0000000000000080 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f01a5177c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01a5346038 R14: 00007f01a5345fa0 R15: 00007ffe12d33220
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 11999 Comm: syz.5.97 Not tainted 7.0.0-rc1 #1 PREEMPT_{RT,(full)} 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x424/0xa30
 panic+0xbe/0xc0
 __warn+0x31c/0x500
 __report_bug+0x28d/0x500
 report_bug_entry+0x19a/0x280
 handle_bug+0xca/0x200
 exc_invalid_op+0x1a/0x50
 asm_exc_invalid_op+0x1a/0x20
RIP: 0010:bpf_check+0x11a79/0x1c9a0
Code: 84 a7 00 00 41 88 1e 83 7c 24 08 00 0f 84 8e 00 00 00 e8 0a 1e de ff e9 fc 40 00 00 e8 00 1e de ff 48 8d 3d f9 87 ef 0f 89 de <67> 48 0f b9 3a 48 8b bc 24 78 01 00 00 48 c7 c6 c0 7f 78 8c 89 da
RSP: 0018:ffffc9000c19f640 EFLAGS: 00010283
RAX: ffffffff81bb16f0 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9000f4d1000 RSI: 0000000000000001 RDI: ffffffff91aa9ef0
RBP: ffffc9000c19fb30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000040 R12: 0000000000000004
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000002
 bpf_prog_load+0x13be/0x19e0
 __sys_bpf+0x5c8/0x8a0
 __x64_sys_bpf+0x81/0x90
 do_syscall_64+0x160/0x760
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f01a50d3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01a3326018 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f01a5345fa0 RCX: 00007f01a50d3b6d
RDX: 0000000000000080 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f01a5177c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01a5346038 R14: 00007f01a5345fa0 R15: 00007ffe12d33220
 </TASK>
Kernel Offset: disabled

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
