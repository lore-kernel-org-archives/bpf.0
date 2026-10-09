Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDF1E1A3D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514171; cv=none; b=s41t7gg6qTGJBxxmYiUwnoEAoO70zfzY5baFkx1eCcgonSh11ksVG4DeZkM0i78Njt9OB9mjOyjTGJ7fHHbXn46kE8FGkK4ulhZoulISKJC5cs5o2kaaq70aGJsuHHZnY/0a0IdjFhTUsxNXTqP+9yu1Zgws4W2xa7GvXGA6ZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514171; c=relaxed/simple;
	bh=4NG7YrN526BQ2Bx9tinnHTtCooBj8jrOVeTaOcGc/LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOr0wwsYMmchD2sBl2QKhwbEOJ4yOtDy5i0/YO/4t0jzLkxNupK8Hp7w3op88l+FjpX9Uk4uGmCdGS3pbKt8KKm/WuFEQ1ih9f7bSFjSdVwopIMCSybonvn4bRjpQxCIYoxVt1/X1AOr7yyPwbQdkiQ5+7Fn8nmBPIESYRUtC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMtBJB61; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMtBJB61"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-46556b9e02cso950325fac.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514169; x=1792118969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fF2xcHShT6tyq3bLONdqeiU0d+t6amntRDspw2GsXbE=;
        b=pMtBJB61yEYlVFqLSBdWeJrf8n7p0s6qxrGlKaRO0COhW7Ebddt/REe/i3pcHmb/GF
         K0a2qLmcaidMKA+4pfsAfCwwnKCaicSGTX1s+cSlLpOUYUCKAQZnnG7cRX3+ool+iSiC
         2Q0o/7dbgpW+9r9LqO9MkgDBtRQa+tlV9vl8mBsvKwH+SymyxvzUxRmqDMpfDJdZ+6+f
         Obm6Vi3xEJHeTpdxtTKZj7t1e/qrkRcK8EmOCz8reaD0pItDOrVjPfY0ga3ckqPx9+AQ
         r/OZOuxSUYS7MuBYJwd+ypig4c40L1DJpGO+L/srHnaV4AeL/H+G+xXmjUQjPWHsUQff
         yGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514169; x=1792118969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fF2xcHShT6tyq3bLONdqeiU0d+t6amntRDspw2GsXbE=;
        b=dvRJ51mdUNIBqP5tRlyiKm6yblZuMqXV3doLiXIt6JnVI4kvywL9rSO4v7sfc6LFrP
         ry38gl4BQPJ7diy8wzn9H7nYvOCoWvDCqJLuy8xbozEgRMn10jW+LGvUUZomFZGwRuuM
         TyGEWZQc4b21odYx2IU/GvtgrM0B4Naw654lWkWHWlJhO/w0fHGz7aXnnk00RW1pDWOR
         zb+h/fQV1BTv76c0dmLr58sX3jbYRhff8f/t7w4CSpmYdEVt5YLtg+AjLoADCroNlEWM
         gxAsie5CaAEkFXg0/8KAUJ6m0Dmu1b/1ApVou6mTvOLvpMcFJ3zH8HnKljrazjCui8Tl
         nWAg==
X-Gm-Message-State: AFq9FYKq+z8dQYn0tv0VMrM+jkRIdDR+YkFGoMXIlkY1DHB4P/12DweM
	CcOp9Ue1l4I/GK419a9oUN2tiyURxhT1uROVKJw+bHVlzkXXw72+XAhFfCfsB56a22A=
X-Gm-Gg: AYBFou1knj+S/Q0B7gNa+/hhVQBjhmrxXCRAF21XjZ+d96qNZL4r1hFcdCkYo/QDi1w
	LcxLaXYClKxRoaN2E2iI0p8zDff83k+wKHzEzPsaFLwgUhwetEPenWdSAV5xv9IZO1RbbmxASqV
	LTquwe0vZ6v+cteCZjf7TrRAQaDXbXfH689qgYp16izZGmjZpfOkGx1XRpeQKhbI1tFE7sSFzJK
	EPNp6XGZFnOKgzN9kuMCh1XkFQBKLPggm8lz73VJF/J3H3HwIaJ6DnF38qpMcOHIAEmyVLJYjw/
	M/Dj+Blw+0DY++MoDy5yIU/x+qLuGEDSC5kp/U0kYWIXTAo/nYqHRLOldHJNjR3ieQQpq4xSrSs
	G4phwep4CkP+2Je50W+Pkv3moy0pYDV7GbmDTn/T0UC2Hle9Ux6RxKcohIc9qicXa5iiVXZajNW
	22DsJuMTao3ywdp8QPY8h5jC1fXzorZEJqg/KPW/r3XQwSYTLxOuCvwXV8eF9FBbIO3Xrc8YbWx
	PnpTM9HovdGHd8tGPHshfDnKv0nnJbBuArOpWngfSoMxKO6dyEGsxJ6HbkLZGXldkk/ewOxkLwf
	iz4PjA==
X-Received: by 2002:a05:6871:1c9:b0:4a2:4e0c:5964 with SMTP id 586e51a60fabf-4a2a49bdb2emr864313fac.18.1791514168581;
        Thu, 08 Oct 2026 19:49:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a858aa3esm787090fac.12.2026.10.08.19.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:49:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/3] bpf, x86: Drop the PROBE_MEM address range check under SMAP
Date: Fri,  9 Oct 2026 04:49:20 +0200
Message-ID: <20261009024925.3169077-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19891; h=from:subject; bh=4NG7YrN526BQ2Bx9tinnHTtCooBj8jrOVeTaOcGc/LQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetEmMjK2S5iUz98Pv9rcvbVP0pfZhxatzY/4zC37Grfq9mu 4ZwbO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjARm0eMDHf1z01wyw218Ez4cE/9nK fRW5ffKvHBMq0Foplpkfyb5zEyfL8+Kz1eyeTN7RV54mdrb3mmffe7yl0xKVPh5+yvu4xsmAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Privileged BPF programs may dereference pointers the verifier cannot prove
valid: fields walked through untrusted pointers, bpf_core_cast() results,
legacy kptr map values. The verifier marks those loads PROBE_MEM and the
JIT attaches an exception table entry to each, so a fault on an invalid
kernel address zeroes the destination register and the program continues.

On x86 that is not enough. With SMAP enabled, do_user_addr_fault() treats a
kernel-mode fault on a user address as a kernel bug and oopses without
consulting the exception table. The JIT therefore precedes every PROBE_MEM
load with a range check against TASK_SIZE_MAX and the vsyscall page: nine
instructions and 32 to 39 bytes in front of a load of four to seven bytes.

Patch 1 lets do_user_addr_fault() resolve the exception table entry when
the faulting instruction belongs to a BPF program. The lookup sits on the
unlikely() branch that ends in page_fault_oops() today, so no fault that is
handled today runs any new code, and a kernel-mode user access without STAC
from anything but JITed BPF code still oopses. Patch 2 drops the range
check from the JIT when SMAP is enabled, leaving the bare load and its
exception table entry, which is what the arm64, riscv, s390 and loongarch
JITs already emit. Kernels without SMAP keep the check.

The series does not change which addresses a program may read. SMAP still
forbids reading user memory, PROBE_MEM loads of kernel addresses are
handled as before, and confidential guests, where reading an unaccepted
page is fatal at any kernel address, are no better and no worse off than
with copy_from_kernel_nofault() today.

Patch 3 adds a selftest that reads through NULL, a low user address, the
last user page, a non-canonical address and the vsyscall page. It passes
before and after the series and oopses on a kernel with only patch 2
applied.

The fault.c change needs an x86 Ack. It can go through tip with the JIT
change following later, or through bpf-next with the Ack, whichever the x86
maintainers prefer.

Results
-------

JITed code size measured with veristat over every BPF selftests object and
over 466 production BPF objects from Meta's fleet, on an x86-64 guest with
SMAP, bpf-next at e1d84a37cba9 with and without the series:

                        programs  with PROBE_MEM  reduction per program
                                                  mean  median    max
  BPF selftests             3324              91  35.0%  37.5%  74.4%
  Meta production programs  1710             228   7.0%   1.8%  69.2%

Programs that walk untrusted pointers lose up to three quarters of their
code and no program grows. Programs without PROBE_MEM loads are unchanged,
which is most of them: loads through trusted pointers and the probe_read
helpers do not use PROBE_MEM.

BPF selftests: 91 of 3324 programs contain PROBE_MEM loads. Their JITed code
shrinks by 35.0% on average, 37.5% median and 74.4% at most; no program
grows.

  Largest relative savings (JITed bytes before->after, saved, percent):
  type_cast/md_xdp                                    1039->  266   -773  -74.4%
  test_lwt_ip_encap/fexit_lwt_push_ip_encap            565->  223   -342  -60.5%
  sock_iter_batch/iter_udp_soreuse                     851->  347   -504  -59.2%
  connect_unix_prog/connect_unix_prog                 1927->  791  -1136  -59.0%
  sendmsg_unix_prog/sendmsg_unix_prog                 1927->  791  -1136  -59.0%
  test_skc_to_unix_sock/unix_listen                    492->  212   -280  -56.9%
  cgrp_ls_attach_cgroup/update_cookie_tracing          272->  119   -153  -56.2%
  bpf_smc/bpf_smc_release                              139->   61    -78  -56.1%
  verifier_typedef/resolve_typedef                      71->   32    -39  -54.9%
  type_cast/md_skb                                     291->  135   -156  -53.6%
  kfree_skb/fentry_eth_type_trans                      148->   70    -78  -52.7%
  bpf_iter_vma_offset/get_vma_offset                   527->  254   -273  -51.8%
  bpf_iter_tcp6/dump_tcp6                             4386-> 2124  -2262  -51.6%
  socket_cookie_prog/update_cookie_tracing             223->  109   -114  -51.1%
  mptcp_sock/_sockops                                  571->  287   -284  -49.7%
  sock_iter_batch/iter_tcp_soreuse                    1437->  733   -704  -49.0%
  mptcp_subflow/_getsockopt_subflow                   2079-> 1067  -1012  -48.7%
  bpf_iter_bpf_sk_storage_helpers/fill_socket_owner    180->   94    -86  -47.8%
  bpf_iter_task_file/dump_task_file                    656->  344   -312  -47.6%
  verifier_kfunc_perfmon/rdonly_cast_noperfmon          82->   43    -39  -47.6%
  bpf_iter_ipv6_route/dump_ipv6_route                  997->  527   -470  -47.1%
  tracing_struct/test_struct_arg_11                     83->   44    -39  -47.0%
  bpf_iter_ksym/dump_ksym                             1219->  649   -570  -46.8%
  kfree_skb/fexit_eth_type_trans                       168->   90    -78  -46.4%
  bpf_iter_unix/dump_unix                             1268->  686   -582  -45.9%
  test_signed_loader_lsm/inspect_prog_load             273->  148   -125  -45.8%
  bpf_iter_tcp4/dump_tcp4                             3485-> 1904  -1581  -45.4%
  bpf_iter_netlink/dump_netlink                        887->  497   -390  -44.0%
  sk_storage_omem_uncharge/bpf_sk_storage_free         190->  108    -82  -43.2%
  bpf_iter_setsockopt/change_tcp_cc                    562->  324   -238  -42.4%
  bpf_iter_task_vmas/proc_maps                        1012->  588   -424  -41.9%
  test_module_attach/handle_fexit_ret                  170->   99    -71  -41.8%
  mptcp_sock/trace_mptcp_pm_new_connection              94->   55    -39  -41.5%
  rcu_read_lock/rcu_untrusted_union_ld                  97->   58    -39  -40.2%
  test_subprogs_extable/handle_fexit_ret_subprogs      177->  106    -71  -40.1%
  test_subprogs_extable/handle_fexit_ret_subprogs2     177->  106    -71  -40.1%
  test_subprogs_extable/handle_fexit_ret_subprogs3     177->  106    -71  -40.1%
  core_kern/fentry_eth_type_trans                      292->  175   -117  -40.1%
  core_kern/fexit_eth_type_trans                       292->  175   -117  -40.1%
  bpf_smc/smc_run                                      226->  136    -90  -39.8%
  test_wakeup_source/iterate_wakeupsources            1150->  696   -454  -39.5%
  lsm/test_sys_setdomainname                           199->  121    -78  -39.2%
  lsm_bdev/bdev_free_security                          100->   61    -39  -39.0%
  bpf_smc/bpf_smc_switch_to_fallback                   103->   64    -39  -37.9%
  test_ldsx_insn/test_ptr_struct_arg                    85->   53    -32  -37.6%
  bpf_iter_setsockopt_unix/change_sndbuf              1060->  662   -398  -37.5%
  fentry_test/test8                                     88->   56    -32  -36.4%
  fexit_test/test8                                      88->   56    -32  -36.4%
  find_vma/handle_getpid                               443->  287   -156  -35.2%
  find_vma/handle_pe                                   443->  287   -156  -35.2%

  Largest absolute savings (JITed bytes before->after, saved, percent):
  bpf_iter_tcp6/dump_tcp6                             4386-> 2124  -2262  -51.6%
  bpf_iter_tcp4/dump_tcp4                             3485-> 1904  -1581  -45.4%
  connect_unix_prog/connect_unix_prog                 1927->  791  -1136  -59.0%
  sendmsg_unix_prog/sendmsg_unix_prog                 1927->  791  -1136  -59.0%
  mptcp_subflow/_getsockopt_subflow                   2079-> 1067  -1012  -48.7%
  type_cast/md_xdp                                    1039->  266   -773  -74.4%
  sock_iter_batch/iter_tcp_soreuse                    1437->  733   -704  -49.0%
  setget_sockopt/skops_sockopt                        5279-> 4602   -677  -12.8%
  bpf_iter_unix/dump_unix                             1268->  686   -582  -45.9%
  bpf_iter_ksym/dump_ksym                             1219->  649   -570  -46.8%
  sock_iter_batch/iter_udp_soreuse                     851->  347   -504  -59.2%
  bpf_iter_ipv6_route/dump_ipv6_route                  997->  527   -470  -47.1%
  test_wakeup_source/iterate_wakeupsources            1150->  696   -454  -39.5%
  bpf_iter_task_vmas/proc_maps                        1012->  588   -424  -41.9%
  bpf_iter_setsockopt_unix/change_sndbuf              1060->  662   -398  -37.5%
  bpf_iter_netlink/dump_netlink                        887->  497   -390  -44.0%
  test_lwt_ip_encap/fexit_lwt_push_ip_encap            565->  223   -342  -60.5%
  bpf_iter_task_file/dump_task_file                    656->  344   -312  -47.6%
  mptcp_sock/_sockops                                  571->  287   -284  -49.7%
  test_skc_to_unix_sock/unix_listen                    492->  212   -280  -56.9%
  bpf_iter_vma_offset/get_vma_offset                   527->  254   -273  -51.8%
  test_tc_tunnel/decap_f                              1262->  989   -273  -21.6%
  bpf_iter_setsockopt/change_tcp_cc                    562->  324   -238  -42.4%
  net_timestamping/skops_sockopt                      1153->  993   -160  -13.9%
  cgroup_hierarchical_stats/flusher                    534->  377   -157  -29.4%
  bpf_ma_ttrace/check_ttrace                           665->  509   -156  -23.5%
  find_vma/handle_getpid                               443->  287   -156  -35.2%
  find_vma/handle_pe                                   443->  287   -156  -35.2%
  type_cast/md_skb                                     291->  135   -156  -53.6%
  cgrp_ls_attach_cgroup/update_cookie_tracing          272->  119   -153  -56.2%
  kfree_skb/trace_kfree_skb                            569->  418   -151  -26.5%
  test_signed_loader_lsm/inspect_prog_load             273->  148   -125  -45.8%
  core_kern/fentry_eth_type_trans                      292->  175   -117  -40.1%
  core_kern/fexit_eth_type_trans                       292->  175   -117  -40.1%
  test_ksyms_btf/handler                               376->  259   -117  -31.1%
  socket_cookie_prog/update_cookie_tracing             223->  109   -114  -51.1%
  bpf_qdisc_fq/bpf_fq_init                             845->  734   -111  -13.1%
  sk_bypass_prot_mem/fentry_tcp_init_sock              429->  319   -110  -25.6%
  sk_bypass_prot_mem/fentry_udp_init_sock              429->  319   -110  -25.6%
  verifier_global_ptr_args/anything_to_untrusted_m~    362->  266    -96  -26.5%
  bpf_smc/smc_run                                      226->  136    -90  -39.8%
  bpf_iter_bpf_sk_storage_helpers/fill_socket_owner    180->   94    -86  -47.8%
  cgroup_ancestor/log_cgroup_id                        248->  162    -86  -34.7%
  test_btf_skc_cls_ingress/cls_ingress                1211-> 1126    -85   -7.0%
  test_tcpbpf_kern/bpf_testcb                         1113-> 1029    -84   -7.5%
  sk_storage_omem_uncharge/bpf_sk_storage_free         190->  108    -82  -43.2%
  test_cgroup1_hierarchy/lsm_s_run                     363->  284    -79  -21.8%
  bpf_smc/bpf_smc_release                              139->   61    -78  -56.1%
  kfree_skb/fentry_eth_type_trans                      148->   70    -78  -52.7%
  kfree_skb/fexit_eth_type_trans                       168->   90    -78  -46.4%

Meta production programs: 228 of 1710 programs contain PROBE_MEM loads.
Their JITed code shrinks by 7.0% on average, 1.8% median and 69.2% at most;
no program grows. Programs are listed by category only.

  Largest relative savings (JITed bytes before->after, saved, percent):
  security enforcement 7      452->  139   -313  -69.2%
  TCP congestion control 5    841->  267   -574  -68.2%
  container runtime 1         789->  315   -474  -60.1%
  network tuning 2            300->  132   -168  -56.0%
  security monitoring 71      147->   69    -78  -53.1%
  profiling 3                 604->  319   -285  -47.2%
  load balancing 3            426->  270   -156  -36.6%
  host monitoring 3          1170->  816   -354  -30.3%
  security monitoring 15      422->  296   -126  -29.9%
  profiling 2                 531->  375   -156  -29.4%
  security monitoring 75      822->  588   -234  -28.5%
  security monitoring 76      861->  627   -234  -27.2%
  security enforcement 2     1781-> 1341   -440  -24.7%
  load balancing 1           1441-> 1093   -348  -24.1%
  load balancing 2           1441-> 1093   -348  -24.1%
  security monitoring 31      137->  105    -32  -23.4%
  network telemetry 3         488->  377   -111  -22.8%
  TCP congestion control 1   2760-> 2136   -624  -22.6%
  network telemetry 2         493->  382   -111  -22.5%
  security monitoring 21      360->  288    -72  -20.0%
  security monitoring 23      360->  288    -72  -20.0%
  network telemetry 6        1130->  907   -223  -19.7%
  network telemetry 1         407->  328    -79  -19.4%
  security enforcement 52     201->  162    -39  -19.4%
  security enforcement 54     206->  167    -39  -18.9%
  security enforcement 55     206->  167    -39  -18.9%
  security monitoring 80     1095->  896   -199  -18.2%
  TCP congestion control 6   4153-> 3529   -624  -15.0%
  security monitoring 19      272->  233    -39  -14.3%
  storage telemetry 7        1433-> 1230   -203  -14.2%
  storage telemetry 1        1436-> 1233   -203  -14.1%
  storage telemetry 5        1436-> 1233   -203  -14.1%
  storage telemetry 9        1436-> 1233   -203  -14.1%
  storage telemetry 11       1436-> 1233   -203  -14.1%
  storage telemetry 17       1436-> 1233   -203  -14.1%
  storage telemetry 2        1444-> 1241   -203  -14.1%
  storage telemetry 3        1444-> 1241   -203  -14.1%
  storage telemetry 10       1444-> 1241   -203  -14.1%
  storage telemetry 12       1444-> 1241   -203  -14.1%
  storage telemetry 13       1444-> 1241   -203  -14.1%
  storage telemetry 14       1444-> 1241   -203  -14.1%
  storage telemetry 15       1444-> 1241   -203  -14.1%
  storage telemetry 16       1444-> 1241   -203  -14.1%
  security enforcement 22     680->  586    -94  -13.8%
  security monitoring 81     1420-> 1224   -196  -13.8%
  security monitoring 67      896->  786   -110  -12.3%
  host monitoring 4           966->  849   -117  -12.1%
  host monitoring 5           288->  256    -32  -11.1%
  host monitoring 1          1785-> 1588   -197  -11.0%
  network tuning 4           2929-> 2613   -316  -10.8%

  Largest absolute savings (JITed bytes before->after, saved, percent):
  security enforcement 40   12217->11588   -629   -5.2%
  TCP congestion control 1   2760-> 2136   -624  -22.6%
  TCP congestion control 3   8456-> 7832   -624   -7.4%
  TCP congestion control 6   4153-> 3529   -624  -15.0%
  security enforcement 46   14109->13486   -623   -4.4%
  security enforcement 48   13941->13319   -622   -4.5%
  security enforcement 42   13783->13193   -590   -4.3%
  TCP congestion control 5    841->  267   -574  -68.2%
  security enforcement 26   11883->11332   -551   -4.6%
  security enforcement 44    9468-> 8917   -551   -5.8%
  security monitoring 68    10867->10324   -543   -5.0%
  security enforcement 8    34695->34181   -514   -1.5%
  security enforcement 9    25952->25440   -512   -2.0%
  security enforcement 12   25993->25481   -512   -2.0%
  security enforcement 13   25993->25481   -512   -2.0%
  security enforcement 14   25993->25481   -512   -2.0%
  security enforcement 10   26290->25779   -511   -1.9%
  container runtime 1         789->  315   -474  -60.1%
  security enforcement 3    25670->25202   -468   -1.8%
  security enforcement 2     1781-> 1341   -440  -24.7%
  security enforcement 58    9190-> 8831   -359   -3.9%
  security enforcement 11   29176->28821   -355   -1.2%
  security enforcement 57   23466->23111   -355   -1.5%
  host monitoring 3          1170->  816   -354  -30.3%
  load balancing 1           1441-> 1093   -348  -24.1%
  load balancing 2           1441-> 1093   -348  -24.1%
  security enforcement 16   25842->25526   -316   -1.2%
  network tuning 3           2957-> 2641   -316  -10.7%
  network tuning 4           2929-> 2613   -316  -10.8%
  security enforcement 7      452->  139   -313  -69.2%
  security monitoring 3     20315->20004   -311   -1.5%
  security enforcement 45   13025->12715   -310   -2.4%
  security enforcement 47   12857->12548   -309   -2.4%
  security enforcement 60    7751-> 7445   -306   -4.0%
  profiling 3                 604->  319   -285  -47.2%
  sched_ext scheduler 9      3389-> 3105   -284   -8.4%
  security enforcement 1    10406->10129   -277   -2.7%
  security enforcement 4     9267-> 8990   -277   -3.0%
  security enforcement 5    20127->19850   -277   -1.4%
  security enforcement 17   31234->30957   -277   -0.9%
  security enforcement 18    8439-> 8162   -277   -3.3%
  security enforcement 19    8439-> 8162   -277   -3.3%
  security enforcement 20    8439-> 8162   -277   -3.3%
  security enforcement 27   10654->10377   -277   -2.6%
  security enforcement 28   11089->10812   -277   -2.5%
  security enforcement 29    8482-> 8205   -277   -3.3%
  security enforcement 30    8479-> 8202   -277   -3.3%
  security enforcement 31    8492-> 8215   -277   -3.3%
  security enforcement 32   16529->16252   -277   -1.7%
  security enforcement 33   16387->16110   -277   -1.7%

The branchless mask Peter suggested for v3 (lea, mov, sar, inc, and, dec in
front of the load, no x86/mm change), measured the same way, gives less
than half of that: 16.2% mean and 35.7% max for the selftests programs,
3.3% mean and 31.9% max for the production programs, with five dependent
ALU instructions left in front of every load. It also keeps the vsyscall
problem: an address with the top bit set passes the mask unchanged, so a
PROBE_MEM load from the vsyscall page still oopses under SMAP, and the
selftest from patch 3 crashes a kernel with that variant at exactly that
address.

Changelog:
----------
v3 -> v4
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

 arch/x86/mm/fault.c                           | 11 +++
 arch/x86/net/bpf_jit_comp.c                   | 21 ++++--
 .../bpf/prog_tests/probe_mem_fault.c          | 69 +++++++++++++++++++
 .../selftests/bpf/progs/probe_mem_fault.c     | 41 +++++++++++
 4 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/probe_mem_fault.c


base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
-- 
2.53.0-Meta

