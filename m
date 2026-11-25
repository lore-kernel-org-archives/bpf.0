Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568039;
	b=QiOL4Slk6svYu1+C5+QksepBv1tRUSBhwydTJYZ1yPqKiaclubHFvVklZ5JRseEGrhEI
	 2PHXOFZLNzgobYVLY5YRpsraVR7myNeHEFemxIG6qIFXCPtrH0pyAEVEwZhfIi12m9LNf
	 NgNlXQSa+698WO6nPTIca7PM+IPwUNc2VDuY03ynLrca9I73mWQa4BbhCKK1H84QB3I5G
	 DnI+VYRCPF4AnkTGh+Gx9BOklmrwZfp9PVJ1VjPb0ZTAHTrPp4y1I6Wq99mPgrkAZJAto
	 wkt4upbad3ABvYTIvca7OaRG9gwKv+LqqwObRFw5vlTDGn64YURhRjBYQbBnZmek2Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568039;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=LKUhl2vfu8qY8Xs2R02bqfFtv08jhN3q+ez3lxFZo7U=;
	b=BrS1ICVn5HWeOc7oGNj+VomQoZaUdFvhsuPNQMlb5KnhrNg4mpvhMr6xYBYbtvXMjcwy
	 sMvqfVJ8IvBIqpRv3j6zQPZsUQJ9SRl9j0Fglf4QWzIZZBbg4mrpmCTf25yCF43MVwyif
	 qU8pPUhp133crPiroGpY5PdJuxDXLMbXltFlQY68KoklCtZ+PleHhJlN9pTXJSgYoAdmH
	 coamhDE/vHp1WsSTicuKga9in2Sd1CzyLk9PBaYmj/b5lQrtMe7Q1k6lZO4BQu1i2K63B
	 RKfeXw+1rZPGHmP4og2FbF5QoRfgRQPy7dW3ib44cA590PSw7DCJxlxKA66FNoQZBkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECEB606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECEB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4f8281066c4so6262289b6e.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795568038; x=1796172838;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKUhl2vfu8qY8Xs2R02bqfFtv08jhN3q+ez3lxFZo7U=;
        b=Cuxi4VW5SBtmnXlGjm1gtmgEdXwM/HqRLV86azhgX7lJs2gTCv1hxmnIqQ1svDTDQE
         EFnS/EmFwbeYqj6hKSGYkcgEwwQP4a6fU9ILGvRmBJPHJW8xwddOqN8t1pG39vBiqGCW
         2AUNktxD/muBMYytI0gVwDXg8j98bb+OqYCDnVyrNIw4qDc5bMYDdURtHFsrKKhtIu2f
         fNu3RXxBgx7eWUKywHm1PGGdBD4h4QAeXCBzZMf0mxVEcEq9qznV8pzzokAsu7+xwVZE
         ZHMU2Rhjenug+sGRhRMKAGdcMg52aG9ZEnYe+5MZVvHZYUnAPoq1k0N7Ux0PAHpYwJPn
         /lsg==
X-Forwarded-Encrypted: i=1; AL+hErFMSrOMeB0PIgZQLrCyN5/gAwcEQvq4+Zb4Xq4GhKfcklRgfsYKN04KuPAcOerh6S9uNWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MoZCpd9MYAigGJ/J+ZgssOsdPg47LHwghkjqZfcvIyEaZ5vmW
	NscVyKhClAO667pAAqWQhEzVfsFC2HkCmd3EFIfI3sDM8yvizzBoxkUfp01O2P0I1aZqsWd2OiH
	qxtbz+Z4lDCiR01iL/DtcF2kzduWd8h30JuM+9f0eF4QJcf47lijh40QiyfU=
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308d:b0:573:b907:d55c with SMTP id
 5614622812f47-57a077150cbmr19544453b6e.7.1795568037944; Tue, 24 Nov 2026
 16:53:57 -0800 (PST)
Date: Tue, 24 Nov 2026 16:53:57 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b0631a5.eee51036.26eb72.03da.GAE@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in bcmp / htab_lru_map_update_elem
From: syzbot <syzbot+542d2bc50fc9545a27d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6a9fa34ce41 Linux 7.4-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17783865580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=886d2ddd2d6b664e
dashboard link: https://syzkaller.appspot.com/bug?extid=542d2bc50fc9545a27d6
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1cd533522ae8/disk-b6a9fa34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19d6c1c369e3/vmlinux-b6a9fa34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfb541770724/bzImage-b6a9fa34.xz

AI-generated root cause summary:
Lockless RCU lookups in `BPF_MAP_TYPE_LRU_HASH` maps (`__lookup_elem_raw()`)
traverse `hlist_nulls` buckets and compare `l->key` via `memcmp()` without
waiting for an RCU grace period when elements are recycled. Concurrently,
`htab_lru_map_update_elem()` -> `prealloc_lru_pop()` evicts/pops an element `l`
via `bpf_lru_pop_free()` (which unlinks it with `hlist_nulls_del_rcu()` and
immediately writes the new `hash`) and overwrites `l->elem.key` with `memcpy()`.
An RCU reader that already loaded `l` and observes `htab_elem_hash(l) == hash`
concurrently executes `memcmp(&l->key, key, key_size)` against the in-progress
`memcpy()`, triggering a KCSAN data race and allowing torn key comparisons.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=542d2bc50fc9545a27d6

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+542d2bc50fc9545a27d6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in bcmp / htab_lru_map_update_elem

write to 0xffff88811ee5cda0 of 280 bytes by task 12413 on cpu 0:
 prealloc_lru_pop kernel/bpf/hashtab.c:407 [inline]
 htab_lru_map_update_elem+0x223/0x7d0 kernel/bpf/hashtab.c:1516
 bpf_map_update_value+0x4f7/0x570 kernel/bpf/syscall.c:297
 generic_map_update_batch+0x4e6/0x700 kernel/bpf/syscall.c:2125
 bpf_map_do_batch+0x26a/0x3b0 kernel/bpf/syscall.c:5849
 __sys_bpf+0x784/0xc50 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:6582 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6579 [inline]
 __x64_sys_bpf+0x69/0x80 kernel/bpf/syscall.c:6579
 x64_sys_call+0xf26/0x2550 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811ee5ce88 of 8 bytes by task 12419 on cpu 1:
 memcmp lib/string.c:665 [inline]
 bcmp+0x23/0x90 lib/string.c:697
 memcmp include/linux/fortify-string.h:675 [inline]
 __lookup_elem_raw kernel/bpf/hashtab.c:827 [inline]
 lookup_nulls_elem_raw kernel/bpf/hashtab.c:865 [inline]
 __htab_lookup kernel/bpf/hashtab.c:889 [inline]
 __htab_map_lookup_elem+0x246/0x390 kernel/bpf/hashtab.c:906
 __htab_lru_map_lookup_elem kernel/bpf/hashtab.c:973 [inline]
 htab_lru_map_lookup_elem_sys+0x1d/0x60 kernel/bpf/hashtab.c:991
 bpf_map_copy_value+0x442/0x500 kernel/bpf/syscall.c:-1
 map_lookup_elem+0x511/0x700 kernel/bpf/syscall.c:1847
 __sys_bpf+0x683/0xc50 kernel/bpf/syscall.c:6440
 __do_sys_bpf kernel/bpf/syscall.c:6582 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6579 [inline]
 __x64_sys_bpf+0x69/0x80 kernel/bpf/syscall.c:6579
 x64_sys_call+0xf26/0x2550 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 12419 Comm: syz.0.3950 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
