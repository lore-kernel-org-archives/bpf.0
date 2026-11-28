Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829341;
	b=iwSkgCasEanAbUvoB2/ITOQFiWVqXz/QPAFSu4iJuEJ3g4PSKVOU5v16if80mWykq5jv
	 aiGtn44JXo6V/4IwT4FOZIZzmurw4an9SEfewaWUxZXaSmbhV84WZGoAssvnUSalKOQQj
	 pfhvB20w3A/DLOIns1vGBfLd7lO0uc+aAE/6Nw1WCGfJrwN7/Uxh20YNVzk5gRrEzExnN
	 H8pmdfVEwC7ZymYIbiHO22fTgdtRmJOEbYSP9UrvRTHrZIezgjjk16eEBGqEOQYPI/UTa
	 moRvw5B6IO7eHDCc1sIifDzO92T3DmMAliuiVRLk3ispn5xHBtiGw5GbVvlSOtM+sow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=eUAulIRr9Zu4AiAFvykX8TUdGYjpqnm4xenVw0jkEZs=;
	b=TWxF5zCn4lEqRaTxVwTYfeki2uN08jSUecT6H2ozQbDLFuzr/Pu/pJ9wNh8zzCbYpTi3
	 T6wus4UaNH24mCmu/IUOFdjyJyidEzvgf9jVH6MprHjV26SddaK4sfnTF4sa9puqcyH2q
	 PeGQ1d+Afj/2eCZKJ08IUyEahloYwmMowhjov90BJlrUGFPbIiByWGrm0XISwl0bQOzFV
	 o713YzwK0h2Zy7UrtSxSOxBfZ5iUwwSJBvHJM46wKB5pHNrm+UG1+veyNLJkz7TUWzfF1
	 f7K43DTWT87U3AbDG2ONPX63tYItXt6OSz6EDqjrRUkCPjGdwCigzTNropYyXp3XAGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMi2igeB;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B00606A32A
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B00606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMi2igeB
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-7033e26cb19so2473594eaf.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795829340; x=1796434140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUAulIRr9Zu4AiAFvykX8TUdGYjpqnm4xenVw0jkEZs=;
        b=IMi2igeB+D1H0r4RXRLRTfyyJ/i4apYP99O3CzAyLrhGgM47yV6xgJhQ5iuYBCJQDp
         j+ZHMhtSZHhME9H3RO6i5idv94+ywBbAOtkP0u9pX8ZyTLVnvSLJAvcFJLUXAsekKnaw
         N/TB4zsy73btf8TBI1IjUjAeT/nwXR+MwoPrSFMGM+od43ffL7nvI1e1U74XVEScKc3j
         svAqJVeASg13KjexJMqRqIMF05sTz28guZDehkjqs2qrLZPXnR0QMA3GteNDhht+XVmU
         6Z/iPyeknsdyFsthrd2qVrk3aN0wgyojVR15nXR/CX5a02/9jArgparJu42sBCkAy6ya
         X3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795829340; x=1796434140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUAulIRr9Zu4AiAFvykX8TUdGYjpqnm4xenVw0jkEZs=;
        b=dZ8pjo3Nc7ViK2CI5azGvEpxmktPP79cOLLU5dYljEHRe5EsWtC6T6qyCxIakC7Jlq
         GfOhZ9cWpxQuLsnCIOnQ9WsN1oITl4MspdnSWSOj0zmcfaAK0E0TK3q6ZIGQr0KDQt+M
         pbVI0OMIZ6xZ/9yByNAD/hdGnZfUV1HffVrzSm3mJy7cJglgGTAI9zmzKwD8Mv1Jdte6
         +t9bYy2KltBEQkbKdpOQATV11HSYtafobGCxzcpKCvClpdSXCjSj7XX5u603EMXIcqU4
         7e+sjfuULx2mJ3eAWBEHVe642bpJmh19fXk4GaqQx7BoGgAahRKLLNB69CETaWBj9AeC
         Xmqw==
X-Gm-Message-State: APuU4Z8z33t9320LJnorBaQPiTzBFd+nLXRHNt8nFg7yk3qF16uNj86/
	80FPpbFH2Io7YJMNXVDAjeSNCbiN9no+zXQoyguuAun6cO095vjIZv7hIwnex55PLrM=
X-Gm-Gg: AZFdTZez0Td2Vglr7VDgyV/+85M5gBGfama6uxC3LoIs6pyWCgdd+Vh7LNYSPL+ov3D
	5US+/gQ3AI2fL+zLpmuaCGpX/zxZyqOBGpYw+l1fz22EY/g3e7RtpS2LvuoHtF51VJB6NETTTs9
	Mknbt5LX1B0LDRrmG38n8s6JZNTag8WcYOi74AmNZUAdvWP7p4uU3NQPImtzgAHv+W9rVldzMkW
	/suheCoLyRU9s7KBDRsiAQyiasNOXYxiQMT7miIwqYVUuwcJWmG1ecyUIptVrP2upmpztKTSIo4
	qyX1IYDWFaQJPU2mUN2ieHwx/wpU1bBpeyqJWfYmERJGImDZzMOR7VkNCqSkqeALnrGu4EUXdbD
	HeaZvsWAn6mpqVmP8fcUuDMBJFPdw+G2dDAvWaUq3+lHIQveXiWTOuKTwlg75gIU8xJ8P4iAzkk
	Zc8/ADq2wvaqgZK40JNCyYhrdEB5INIFr5+kMCPB7cIQpMUFDKNxd1Acdke0RROX0Db4KOSGInx
	cdJJh1JyLggcwjHZI9JQxNnmXyxJyY+6wrqrvZy7Ir7Hc4qMyHxDSY4PTCuuUf9UuovF9Ru8pdH
	E+skY+7cnImh5aFOqF7mdhSX+1+k0xQitgAG/xXau4GK0INuRCqI/L+GlDD26F/xlZbqq+PucO5
	eteqXOKJO5gp4ItI9pznSqhNQ6PXtU70WMMwG
X-Received: by 2002:a05:6820:410b:b0:71b:8dd:7e8c with SMTP id 006d021491bc7-71b394899bdmr19349958eaf.28.1795829339752;
        Fri, 27 Nov 2026 17:28:59 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806ef20sm17227849eaf.7.2026.11.27.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:28:58 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf, x86: Drop the PROBE_MEM address range check under SMAP
Date: Sat, 28 Nov 2026 02:28:53 +0100
Message-ID: <cover.1795829324.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21478; h=from:subject:message-id; bh=omn+sBk3KgFYHE/2h/juNxBfoDyBsG/IMxBZK5LBBjs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtLz+eO3I0NUXc4JP5YvWtVCNyVcc3/J9Nq/UjtkFDBvqKv rrM6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFHNowM/3vj3+cXNt087Kq4cpPkzX NTEuaVHH7wlfFE0K9bL9JfBDL8s913agHz3SPGX65dffO8pcH6xZwFlycYspcLMF6yrLuSyg0A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

GPL-compatible BPF programs loaded with CAP_PERFMON can read through
pointers that the verifier cannot prove valid. The verifier marks such
loads PROBE_MEM and the JIT gives each one an exception table entry: on a
fault, the destination register is zeroed and the program continues. Each
load is a single mov, movzx, movsx or movsxd into a register, and it is not
retried.

On x86 this does not work for user addresses. With SMAP, a kernel-mode
fault on a user address oopses without looking at the exception table, so
the JIT puts a range check in front of every PROBE_MEM load: five
instructions and 17 or 18 bytes, for a load of three to eight bytes.

Patch 1 lets do_user_addr_fault() fix up such a fault when it came from
kernel mode, is a read, and the faulting instruction has an EX_TYPE_BPF
exception table entry. Every other fault there still oopses. Patch 2 drops
the range check from the JIT when SMAP is enabled. Patch 3 adds a selftest
that reads through NULL, user, guard page, non-canonical and vsyscall
addresses. It oopses on a kernel with only patch 2 applied.

Limits:

 * Kernels without SMAP keep the range check.
 * Programs loaded without CAP_BPF keep it too. They are not in kallsyms,
   so the fault handler cannot find their exception table.
 * The addresses a program can read do not change. SMAP still refuses user
   memory. MMIO and, in confidential guests, unaccepted pages are filtered
   neither by the range check nor by copy_from_kernel_nofault(), before or
   after the series. Patch 1 has a table.

Patch 2 depends on patch 1, so the series is meant for bpf-next as a whole.
Patch 1 needs an x86 Ack.

Results
-------

JITed code size from veristat, on one kernel booted with and without
clearcpuid=smap (bpf-next at 8dfce13340ae with the series), over the BPF
selftests and 474 production objects from Meta:

                        programs  with PROBE_MEM  reduction per program
                                                  mean  median    max
  BPF selftests             5486             100  20.2%  19.9%  58.2%
  Meta production programs  1942             262   3.5%   0.8%  51.4%

No program grows. Most programs are unchanged, because loads through
trusted pointers and the probe_read helpers do not use PROBE_MEM.

The branchless mask Peter suggested for v3 (lea, mov, sar, inc, and, dec,
no x86/mm change) was measured the same way on bpf-next at 0fb18ce8a2e9. It
is larger than the current range check: programs with PROBE_MEM loads grow
by 2.9% on average in the selftests and by 0.5% in production. It also lets
the vsyscall page through, so such a load still oopses under SMAP, and the
selftest from patch 3 crashes that kernel at that address.

BPF selftests:

  Largest relative savings (JITed bytes before->after, saved, percent):
  type_cast/md_xdp                                    584->  244   -340  -58.2%
  connect_unix_prog/connect_unix_prog                1075->  571   -504  -46.9%
  sendmsg_unix_prog/sendmsg_unix_prog                1075->  571   -504  -46.9%
  test_lwt_ip_encap/fexit_lwt_push_ip_encap           362->  205   -157  -43.4%
  sock_iter_batch/iter_udp_soreuse                    548->  327   -221  -40.3%
  test_skc_to_unix_sock/unix_listen                   330->  205   -125  -37.9%
  bpf_smc/bpf_smc_release                              90->   56    -34  -37.8%
  cgrp_ls_attach_cgroup/update_cookie_tracing         183->  115    -68  -37.2%
  verifier_typedef/resolve_typedef                     48->   31    -17  -35.4%
  bpf_iter_vma_offset/get_vma_offset                  369->  240   -129  -35.0%
  type_cast/md_skb                                    198->  130    -68  -34.3%
  kfree_skb/fentry_eth_type_trans                     102->   68    -34  -33.3%
  socket_cookie_prog/update_cookie_tracing            156->  105    -51  -32.7%
  bpf_iter_tcp6/dump_tcp6                            3142-> 2129  -1013  -32.2%
  mptcp_sock/_sockops                                 410->  280   -130  -31.7%
  plain_c_mptcp_subflow/_getsockopt_subflow          1433->  980   -453  -31.6%
  mptcp_subflow/_getsockopt_subflow                  1462-> 1012   -450  -30.8%
  mem_rdonly_untrusted/btf_id_to_ptr_mem              118->   82    -36  -30.5%
  sock_iter_batch/iter_tcp_soreuse                   1025->  714   -311  -30.3%
  test_signed_loader_lsm/inspect_prog_load            197->  138    -59  -29.9%
  bpf_iter_task_file/dump_task_file                   464->  328   -136  -29.3%
  verifier_kfunc_perfmon/rdonly_cast_noperfmon         59->   42    -17  -28.8%
  bpf_iter_ksym/dump_ksym                             900->  642   -258  -28.7%
  plain_c_test_wakeup_source/iterate_wakeupsources    719->  513   -206  -28.7%
  kfree_skb/fexit_eth_type_trans                      119->   85    -34  -28.6%
  bpf_iter_unix/dump_unix                             897->  641   -256  -28.5%
  bpf_iter_ipv6_route/dump_ipv6_route                 725->  519   -206  -28.4%
  bpf_iter_tcp4/dump_tcp4                            2621-> 1914   -707  -27.0%
  bpf_iter_bpf_sk_storage_helpers/fill_socket_owner   127->   93    -34  -26.8%
  bpf_iter_netlink/dump_netlink                       660->  490   -170  -25.8%
  sk_storage_omem_uncharge/bpf_sk_storage_free        135->  101    -34  -25.2%
  bpf_iter_setsockopt/change_tcp_cc                   409->  307   -102  -24.9%
  bpf_iter_task_vmas/proc_maps                        766->  577   -189  -24.7%
  fentry_test/test8                                    70->   53    -17  -24.3%
  fexit_test/test8                                     70->   53    -17  -24.3%
  mptcp_sock/trace_mptcp_pm_new_connection             70->   53    -17  -24.3%
  test_wakeup_source/iterate_wakeupsources            867->  660   -207  -23.9%
  core_kern/fentry_eth_type_trans                     219->  168    -51  -23.3%
  core_kern/fexit_eth_type_trans                      219->  168    -51  -23.3%
  rcu_read_lock/rcu_untrusted_union_ld                 73->   56    -17  -23.3%
  lsm/test_sys_setdomainname                          148->  114    -34  -23.0%
  lsm_bdev/bdev_free_security                          74->   57    -17  -23.0%
  plain_c_mem_rdonly_untrusted/offset_not_tracked      75->   58    -17  -22.7%
  bpf_smc/bpf_smc_switch_to_fallback                   77->   60    -17  -22.1%
  verifier_kfunc_perfmon/arg_untrusted_read_noperf~    77->   60    -17  -22.1%
  verifier_btf_array_access/flex_array_far_join        78->   61    -17  -21.8%
  bpf_iter_setsockopt_unix/change_sndbuf              822->  644   -178  -21.7%
  btf_type_tag_percpu/test_percpu_helper               81->   64    -17  -21.0%
  bpf_smc/smc_run                                     167->  133    -34  -20.4%
  find_vma/handle_getpid                              342->  274    -68  -19.9%

  Largest absolute savings (JITed bytes before->after, saved, percent):
  bpf_iter_tcp6/dump_tcp6                            3142-> 2129  -1013  -32.2%
  bpf_iter_tcp4/dump_tcp4                            2621-> 1914   -707  -27.0%
  connect_unix_prog/connect_unix_prog                1075->  571   -504  -46.9%
  sendmsg_unix_prog/sendmsg_unix_prog                1075->  571   -504  -46.9%
  plain_c_mptcp_subflow/_getsockopt_subflow          1433->  980   -453  -31.6%
  mptcp_subflow/_getsockopt_subflow                  1462-> 1012   -450  -30.8%
  type_cast/md_xdp                                    584->  244   -340  -58.2%
  sock_iter_batch/iter_tcp_soreuse                   1025->  714   -311  -30.3%
  setget_sockopt/skops_sockopt                       4862-> 4563   -299   -6.1%
  bpf_iter_ksym/dump_ksym                             900->  642   -258  -28.7%
  bpf_iter_unix/dump_unix                             897->  641   -256  -28.5%
  sock_iter_batch/iter_udp_soreuse                    548->  327   -221  -40.3%
  test_wakeup_source/iterate_wakeupsources            867->  660   -207  -23.9%
  bpf_iter_ipv6_route/dump_ipv6_route                 725->  519   -206  -28.4%
  plain_c_test_wakeup_source/iterate_wakeupsources    719->  513   -206  -28.7%
  bpf_iter_task_vmas/proc_maps                        766->  577   -189  -24.7%
  bpf_iter_setsockopt_unix/change_sndbuf              822->  644   -178  -21.7%
  bpf_iter_netlink/dump_netlink                       660->  490   -170  -25.8%
  test_lwt_ip_encap/fexit_lwt_push_ip_encap           362->  205   -157  -43.4%
  bpf_iter_task_file/dump_task_file                   464->  328   -136  -29.3%
  mptcp_sock/_sockops                                 410->  280   -130  -31.7%
  bpf_iter_vma_offset/get_vma_offset                  369->  240   -129  -35.0%
  test_skc_to_unix_sock/unix_listen                   330->  205   -125  -37.9%
  test_tc_tunnel/decap_f                             1074->  955   -119  -11.1%
  bpf_iter_setsockopt/change_tcp_cc                   409->  307   -102  -24.9%
  kfree_skb/trace_kfree_skb                           479->  409    -70  -14.6%
  cgroup_hierarchical_stats/flusher                   430->  361    -69  -16.0%
  bpf_ma_ttrace/check_ttrace                          548->  480    -68  -12.4%
  cgrp_ls_attach_cgroup/update_cookie_tracing         183->  115    -68  -37.2%
  find_vma/handle_getpid                              342->  274    -68  -19.9%
  find_vma/handle_pe                                  342->  274    -68  -19.9%
  net_timestamping/skops_sockopt                     1043->  975    -68   -6.5%
  plain_c_bpf_ma_ttrace/check_ttrace                  397->  329    -68  -17.1%
  type_cast/md_skb                                    198->  130    -68  -34.3%
  test_signed_loader_lsm/inspect_prog_load            197->  138    -59  -29.9%
  bpf_qdisc_fq/bpf_fq_init                            765->  713    -52   -6.8%
  plain_c_bpf_qdisc_fq/bpf_fq_init                    765->  713    -52   -6.8%
  core_kern/fentry_eth_type_trans                     219->  168    -51  -23.3%
  core_kern/fexit_eth_type_trans                      219->  168    -51  -23.3%
  sk_bypass_prot_mem/fentry_tcp_init_sock             357->  306    -51  -14.3%
  sk_bypass_prot_mem/fentry_udp_init_sock             357->  306    -51  -14.3%
  socket_cookie_prog/update_cookie_tracing            156->  105    -51  -32.7%
  tcp_autolowat/tcp_autolowat_enqueue_rcvq            670->  619    -51   -7.6%
  test_ksyms_btf/handler                              300->  249    -51  -17.0%
  verifier_global_ptr_args/anything_to_untrusted_m~   313->  262    -51  -16.3%
  test_tcpbpf_kern/bpf_testcb                        1029->  989    -40   -3.9%
  test_cgroup1_hierarchy/lsm_s_run                    306->  267    -39  -12.7%
  cgroup_ancestor/log_cgroup_id                       196->  158    -38  -19.4%
  tcp_autolowat/tcp_autolowat_setsockopt              271->  233    -38  -14.0%
  test_btf_skc_cls_ingress/cls_ingress               1107-> 1069    -38   -3.4%

Meta production programs, listed by category only:

  Largest relative savings (JITed bytes before->after, saved, percent):
  security enforcement 14     280->  136   -144  -51.4%
  TCP congestion control 24   511->  257   -254  -49.7%
  container runtime 9         520->  310   -210  -40.4%
  network tuning 46           201->  125    -76  -37.8%
  security monitoring 145     100->   66    -34  -34.0%
  profiling 22                433->  310   -123  -28.4%
  security monitoring 35      154->  119    -35  -22.7%
  security monitoring 37      154->  119    -35  -22.7%
  security monitoring 33       83->   66    -17  -20.5%
  security monitoring 25      346->  287    -59  -17.1%
  load balancing 20           401->  333    -68  -17.0%
  profiling 21                426->  358    -68  -16.0%
  host monitoring 10          983->  830   -153  -15.6%
  security monitoring 157     675->  573   -102  -15.1%
  security monitoring 158     711->  609   -102  -14.3%
  security monitoring 48      119->  102    -17  -14.3%
  security enforcement 2     1487-> 1293   -194  -13.0%
  network telemetry 4         423->  371    -52  -12.3%
  network telemetry 3         428->  376    -52  -12.1%
  TCP congestion control 3   2344-> 2072   -272  -11.6%
  TCP congestion control 10  2344-> 2072   -272  -11.6%
  network telemetry 18        982->  880   -102  -10.4%
  security enforcement 85     170->  153    -17  -10.0%
  security enforcement 92     175->  158    -17   -9.7%
  security enforcement 93     175->  158    -17   -9.7%
  network telemetry 2         361->  326    -35   -9.7%
  security monitoring 194     975->  889    -86   -8.8%
  TCP congestion control 26  3699-> 3427   -272   -7.4%
  TCP congestion control 32  3699-> 3427   -272   -7.4%
  storage telemetry 44       1297-> 1208    -89   -6.9%
  storage telemetry 36       1300-> 1211    -89   -6.8%
  storage telemetry 42       1300-> 1211    -89   -6.8%
  storage telemetry 46       1300-> 1211    -89   -6.8%
  storage telemetry 50       1300-> 1211    -89   -6.8%
  storage telemetry 71       1300-> 1211    -89   -6.8%
  storage telemetry 38       1308-> 1219    -89   -6.8%
  storage telemetry 40       1308-> 1219    -89   -6.8%
  storage telemetry 48       1308-> 1219    -89   -6.8%
  storage telemetry 52       1308-> 1219    -89   -6.8%
  storage telemetry 54       1308-> 1219    -89   -6.8%
  storage telemetry 56       1308-> 1219    -89   -6.8%
  storage telemetry 58       1308-> 1219    -89   -6.8%
  storage telemetry 60       1308-> 1219    -89   -6.8%
  security monitoring 197    1301-> 1215    -86   -6.6%
  host monitoring 11          801->  750    -51   -6.4%
  security monitoring 114     844->  793    -51   -6.0%
  security enforcement 34     606->  572    -34   -5.6%
  host monitoring 12          303->  286    -17   -5.6%
  network tuning 48          2619-> 2479   -140   -5.3%
  security enforcement 110   6224-> 5894   -330   -5.3%

  Largest absolute savings (JITed bytes before->after, saved, percent):
  security enforcement 77   13763->13404   -359   -2.6%
  security enforcement 110   6224-> 5894   -330   -5.3%
  security enforcement 75   13240->12966   -274   -2.1%
  security enforcement 69   11670->11397   -273   -2.3%
  TCP congestion control 3   2344-> 2072   -272  -11.6%
  TCP congestion control 10  2344-> 2072   -272  -11.6%
  TCP congestion control 26  3699-> 3427   -272   -7.4%
  TCP congestion control 32  3699-> 3427   -272   -7.4%
  load balancing 15          5059-> 4797   -262   -5.2%
  load balancing 16          5059-> 4797   -262   -5.2%
  security enforcement 71   13064->12808   -256   -2.0%
  TCP congestion control 24   511->  257   -254  -49.7%
  security enforcement 46   11198->10955   -243   -2.2%
  security monitoring 115   10522->10280   -242   -2.3%
  security enforcement 73    9054-> 8815   -239   -2.6%
  security enforcement 15   33473->33249   -224   -0.7%
  security enforcement 16   25000->24778   -222   -0.9%
  security enforcement 19   25039->24817   -222   -0.9%
  security enforcement 20   25039->24817   -222   -0.9%
  security enforcement 21   25039->24817   -222   -0.9%
  security enforcement 76   12863->12641   -222   -1.7%
  security enforcement 17   25336->25115   -221   -0.9%
  container runtime 9         520->  310   -210  -40.4%
  security enforcement 4    24666->24459   -207   -0.8%
  security enforcement 2     1487-> 1293   -194  -13.0%
  security enforcement 18   28083->27895   -188   -0.7%
  security enforcement 50   10779->10626   -153   -1.4%
  security enforcement 97   22794->22641   -153   -0.7%
  security enforcement 98    8869-> 8716   -153   -1.7%
  host monitoring 10          983->  830   -153  -15.6%
  security enforcement 14     280->  136   -144  -51.4%
  security monitoring 5     20270->20128   -142   -0.7%
  security enforcement 61   25296->25156   -140   -0.6%
  security enforcement 64   25296->25156   -140   -0.6%
  security enforcement 65   20458->20318   -140   -0.7%
  network tuning 47          2644-> 2504   -140   -5.3%
  network tuning 48          2619-> 2479   -140   -5.3%
  security enforcement 74   12340->12203   -137   -1.1%
  security enforcement 24   25005->24869   -136   -0.5%
  security enforcement 1    10135->10012   -123   -1.2%
  security enforcement 8    19588->19465   -123   -0.6%
  security enforcement 56   16559->16436   -123   -0.7%
  security enforcement 57   17098->16975   -123   -0.7%
  security enforcement 58   18871->18748   -123   -0.7%
  security enforcement 59   16532->16409   -123   -0.7%
  security enforcement 62   22632->22509   -123   -0.5%
  security enforcement 66   22632->22509   -123   -0.5%
  security enforcement 101  15340->15217   -123   -0.8%
  profiling 22                433->  310   -123  -28.4%
  security enforcement 44   16189->16069   -120   -0.7%

Changelog:
----------
v1 (Reworked) -> v2
v1: https://lore.kernel.org/bpf/20261009024925.3169077-1-memxor@gmail.com

 * Keep the range check for programs loaded without CAP_BPF, which are not
   registered in kallsyms, so the fault handler cannot find their exception
   table entries; add bpf_prog_kallsyms_allowed() for the decision. (BPF CI)
 * Stop crediting arm64, riscv and loongarch with bare PROBE_MEM loads; they
   use the verifier's generic user address guard. (BPF CI)
 * Mention the LASS #GP path in the JIT comment and the commit messages, and
   update the bpf_arch_uaddress_limit() comment. (BPF CI)
 * Rewrite the commit message of patch 1 around a concrete program and the
   check the JIT emits for it, without references to neighbouring
   patches. (Boris)
 * Use __u64 for the test addresses and the BPF global. (Sashiko)
 * Cover the last user page and the guard page of both paging layouts in
   the selftest.
 * Leave the NULL and low user address subtests out on s390x, which has its
   lowcore there.
 * Rebase on bpf-next, where the range check is down to five instructions and 17
   or 18 bytes (lea, shr, jne, xor, jmp); redo the code size measurements
   against it, over 474 current production objects.
 * Take the listing in the commit message of patch 1 from the JIT; the offsets
   in the old one were wrong.
 * Report that the branchless mask now produces larger code than the range check
   in bpf-next.
 * Rebase onto commit 4eaf4d71b91a ("bpf: Keep the symbols of a program until it
   has ended"), which keeps a program in kallsyms until it can no longer run, so
   a faulting load in a program whose last reference is gone still finds its
   exception table. (Sashiko)
 * Check for kernel mode, a read fault and an EX_TYPE_BPF exception table entry
   in do_user_addr_fault() instead of is_bpf_text_address(). (Boris, Alexei)
 * List the instructions a PROBE_MEM entry covers and say what the fixup does.
   (Dave)
 * Replace the comparison with get_kernel_nofault() by a table of who refuses
   which address. (Dave)
 * Say that MMIO is filtered neither before nor after the series. (Andy)
 * Say that PROBE_MEM needs CAP_PERFMON and a GPL-compatible program. (Dave)
 * Aim the series at bpf-next as a whole, since patch 2 depends on patch 1.
   (Alexei)
 * Drop Puranjay's Ack on patch 1 since the check changed.
 * Shorten the commit messages of patches 1 and 2 and the cover letter.

v3 -> v1 (Reworked)
v3: https://lore.kernel.org/bpf/20241103193512.4076710-1-memxor@gmail.com

 * Rebase on bpf-next.
 * Drop "zero overhead" from the title and state the fault handler cost up
   front. (Dave)
 * Spell out what the series does and does not change for confidential
   guests. (Dave)
 * Measure code size over the selftests and Meta production objects, for
   this series and for the branchless mask alternative. (Peter)
 * Add a selftest for PROBE_MEM loads from user, vsyscall and non-canonical
   addresses.
 * Call fixup_exception() directly in the SMAP branch and fall through to
   the existing page_fault_oops() instead of kernelmode_fixup_or_oops().
 * Restructure the JIT change around probe_mem and bounds_check flags
   instead of a goto; drop Puranjay's Ack on it since the code changed.

v2 -> v3
v2: https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com

 * Rebase on bpf-next
 * Add Puranjay's Acks

v1 -> v2
v1: https://lore.kernel.org/bpf/20240515233932.3733815-1-memxor@gmail.com

 * Rebase on bpf-next

Kumar Kartikeya Dwivedi (3):
  x86/mm: Resolve BPF exception fixups for user address faults under
    SMAP
  bpf, x86: Skip the PROBE_MEM address range check under SMAP
  selftests/bpf: Test PROBE_MEM loads from invalid addresses

 arch/x86/mm/fault.c                           | 11 ++-
 arch/x86/net/bpf_jit_comp.c                   | 33 ++++++--
 include/linux/bpf.h                           |  1 +
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             | 16 +++-
 kernel/bpf/syscall.c                          |  1 +
 .../bpf/prog_tests/probe_mem_fault.c          | 77 +++++++++++++++++++
 .../selftests/bpf/progs/probe_mem_fault.c     | 41 ++++++++++
 8 files changed, 172 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/probe_mem_fault.c


base-commit: 7bba28b399b36f6d50f904a53cfe900e79f1e1e5
-- 
2.53.1-Meta

