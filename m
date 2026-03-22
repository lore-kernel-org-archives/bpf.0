Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540F1DED4C
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219890; cv=none; b=oSotqnzmD7LUHdSxes8H6gkY1U3pPGYd1EJsuiynnxeXap8+OlVGS7O69UJWSJtnPoAVa7W4/sgFpyMmmguIMcglXIf+Y6Z7zZbIINDPgF8ZZHcY/aB4S6v0qRc+u+dOKtK6TX0ti0O9ABYPMUTRiUV99YvQRb17lsrrRMcaYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219890; c=relaxed/simple;
	bh=Nk24/+XY1Uw0qgE34QzSE1T6WGjBIdeRUh7HSaI1RHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M3wsURx0HsEEqrG8TLNq9nKYNOP3XCkKaa7sTcWrGA9V3JXP5uC+dP+RRZ/0fqUSMwWZZEmSajme6+QCzs3Le5llNEOf0JvROC01BEculUT1ChsK8/2LvPeCTXkXkhWlLtO+NU50Dsn9EC0ot4mN3iQh4ZvFyBTwutJAeIQEvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSZM1Yxu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZM1Yxu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adff872068so9503365ad.1
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774219888; x=1774824688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8v2ujU/F9KxqY3vS2zqr6XZ5Ew9ZzTNiBaCQEZuuxpw=;
        b=mSZM1YxuSLRhmXgD7uex2Ss8rlbsD/aNRar43oRjWhHMFCdAQmAzm+IcA8RnHl5n5n
         rBHZ/cYWpSX4MtKEgylFT3gnuKGsVxscEwUHOYocML0+wfdB+DkUw1+ZHDfHmvRZVsmE
         OeGamo5IPVYtHhy7fl5SROvecVlsWlt5OKWC5peCYc/czyeQFMyOuRsMvdgN5ZDYYmR+
         nJBXIV5huQZkExWbXKNoVARsMDoQWQHp85hsXwWJkOemWbPcBaetm1HnZNprnfcbTdDl
         zcDShbnr/3tCnfgnP1465v2Wx9wmNISOaYuL2of3EZo3Xdi0s9GwHby3NWQoJhteUxRw
         AwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219888; x=1774824688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v2ujU/F9KxqY3vS2zqr6XZ5Ew9ZzTNiBaCQEZuuxpw=;
        b=pOKIPPcWjXm7UKa1BHwSROg8vDDF7Z/iy0pIiZ/u0P/me1ud1UcaJxOJoGKBDfN+Rk
         nFY/3EJY/F74HAfqAcSHhXpYZRm/vxdNKhTEqNF2rkP64pgYPyuS0BP7+Wei9Sgh4ax1
         feRjlu44la+5OkClpPjGVMQwjeuZSNFeu+W3pmUSgvA3KtlTVRzzvX+n6D0OBTSgnxRa
         eadBYLG9f96lkFbTvyd6N9hU4U707GPimQs0WXri+XbvAEZ2oktGabM0vofXuLlKsiFy
         8UGJZVHTP+Hj6JULYwc1xdO5wgm7IxBPcCNdwdnWEXO3J/TREBBToyD0SseskUjNvk87
         smfw==
X-Gm-Message-State: AOJu0YwYoUt4pGazaejRhaXkFZ+A/+Dyzig9wAUKEGjwdT45lWnS1z2Q
	ehQ1icVqGzPxbI6u8HKURwrE/r/DAE8spNWo0BFkngMSGJIYo73Ju4SRsaoQdw==
X-Gm-Gg: ATEYQzxGzKxgmOCgdhKS8nLHzcolwSjFy8J4JhNuXIksTqArxVbOT31hqwodBOzDnFm
	FUD08BgxGOLC4JScN+l299/2jJngGjDA6vIjHmuGufssVpS56gP8llDiKGyN/kE75/ao1WcQSiT
	QQGwC7ZW28BvPZBEKtQpthGqp9UeHlITqRMOQC9ohPVJvOGzl/e8f029+WKn1xJXQOSMw3MQOu4
	YLZLsvOZdtQ5odWx4GdxB8OGjYZY4L0CHuFD0Y9xoChpUkARZcsSSoGSj8YrVrAZLukVSf5Mb0k
	P7ZjVjivSDNSlNi8TgXAhTD9HCz8/C1DPonRsm7kFxLgz/zHJuJMzV2/NLiX4BXpXri0Td0NXuO
	2npF2yFbJfYEqug/ZLrZf/2JmtwgtJaGssV7FtoPBtDX6ptBqJ48zco7XztoysmS8xxK/gSIXuA
	LhbkSB2OSbyLHXkNZoGFf3TYCfb8YVlHL0R5WuAbXQjTKLYws8QaENAt1XA5gSKhvA4cy+SZhm/
	pk+7MWWVi2azTnfZGYjj+LEZ5KWIDV2OdR0OnJljiQamyQ2UiHTrcYqCXnGpA==
X-Received: by 2002:a17:902:dad1:b0:2ae:cb0e:fd5e with SMTP id d9443c01a7336-2b08275878cmr102773475ad.23.1774219887968;
        Sun, 22 Mar 2026 15:51:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354b109sm112777415ad.31.2026.03.22.15.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 15:51:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Support 32-bit scalar spills in stacksafe()
Date: Sun, 22 Mar 2026 15:51:23 -0700
Message-ID: <20260322225124.14005-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The commit 6efbde200bf3 ("bpf: Handle scalar spill vs all MISC in stacksafe()")
in stacksafe() only recognized full 64-bit scalar spills when
comparing stack states for equivalence during state pruning and
missed 32-bit scalar spill. When 32-bit scalar is spilled the
check_stack_write_fixed_off() -> save_register_state() populates
slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL and updates spilled_ptr.

The im=4 path is only reached when im=0 fails: The loop at im=0 already
attempts the 64-bit scalar-spill/all-MISC check. If it matches, i advances
by 7, skipping the entire 8-byte slot. So im=4 is only reached when bytes
0-3 are neither a scalar spill nor all-MISC — they must pass individual
byte-by-byte comparison first. Then bytes 4-7 get the scalar-unit
treatment.

is_spilled_scalar_after(stack, 4): slot_type[4] == STACK_SPILL from a
64-bit spill would have been caught at im=0 (unless it's a pointer spill,
in which case spilled_ptr.type != SCALAR_VALUE -> returns false at im=4
too). A partial overwrite of a 64-bit spill invalidates the entire slot in
check_stack_write_fixed_off().

is_stack_misc_after(stack, 4): Only checks bytes 4-7 are MISC/INVALID,
returns &unbound_reg. Comparing two unbound regs via regsafe() is safe.

Changes to cilium programs:
File             Program                            Insns (A)  Insns (B)  Insns     (DIFF)
_______________  _________________________________  _________  _________  ________________
bpf_host.o       cil_host_policy                        49351      45811    -3540 (-7.17%)
bpf_host.o       cil_to_host                             2384       2270     -114 (-4.78%)
bpf_host.o       cil_to_netdev                         112051     100269  -11782 (-10.51%)
bpf_host.o       tail_handle_ipv4_cont_from_host        61175      60910     -265 (-0.43%)
bpf_host.o       tail_handle_ipv4_cont_from_netdev       9381       8873     -508 (-5.42%)
bpf_host.o       tail_handle_ipv4_from_host             12994       7066   -5928 (-45.62%)
bpf_host.o       tail_handle_ipv4_from_netdev           85015      59875  -25140 (-29.57%)
bpf_host.o       tail_handle_ipv6_cont_from_host        24732      23527    -1205 (-4.87%)
bpf_host.o       tail_handle_ipv6_cont_from_netdev       9463       8953     -510 (-5.39%)
bpf_host.o       tail_handle_ipv6_from_host             12477      11787     -690 (-5.53%)
bpf_host.o       tail_handle_ipv6_from_netdev           30814      30017     -797 (-2.59%)
bpf_host.o       tail_handle_nat_fwd_ipv4                8943       8860      -83 (-0.93%)
bpf_host.o       tail_handle_snat_fwd_ipv4              64716      61625    -3091 (-4.78%)
bpf_host.o       tail_handle_snat_fwd_ipv6              48299      30797  -17502 (-36.24%)
bpf_host.o       tail_ipv4_host_policy_ingress          21591      20017    -1574 (-7.29%)
bpf_host.o       tail_ipv6_host_policy_ingress          21177      20693     -484 (-2.29%)
bpf_host.o       tail_nodeport_nat_egress_ipv4          16588      16543      -45 (-0.27%)
bpf_host.o       tail_nodeport_nat_ingress_ipv4         39200      36116    -3084 (-7.87%)
bpf_host.o       tail_nodeport_nat_ingress_ipv6         50102      48003    -2099 (-4.19%)
bpf_lxc.o        tail_handle_ipv4_cont                 113092      96891  -16201 (-14.33%)
bpf_lxc.o        tail_handle_ipv6                        6727       6701      -26 (-0.39%)
bpf_lxc.o        tail_handle_ipv6_cont                  25567      21805   -3762 (-14.71%)
bpf_lxc.o        tail_ipv4_ct_egress                    28843      15970  -12873 (-44.63%)
bpf_lxc.o        tail_ipv4_ct_ingress                   16691      10213   -6478 (-38.81%)
bpf_lxc.o        tail_ipv4_ct_ingress_policy_only       16691      10213   -6478 (-38.81%)
bpf_lxc.o        tail_ipv4_policy                        6776       6622     -154 (-2.27%)
bpf_lxc.o        tail_ipv4_to_endpoint                   7523       7219     -304 (-4.04%)
bpf_lxc.o        tail_ipv6_ct_egress                    10275       9999     -276 (-2.69%)
bpf_lxc.o        tail_ipv6_ct_ingress                    6466       6438      -28 (-0.43%)
bpf_lxc.o        tail_ipv6_ct_ingress_policy_only        6466       6438      -28 (-0.43%)
bpf_lxc.o        tail_ipv6_policy                        6859       5159   -1700 (-24.78%)
bpf_lxc.o        tail_ipv6_to_endpoint                   7039       4427   -2612 (-37.11%)
bpf_lxc.o        tail_nodeport_ipv6_dsr                  1175       1033    -142 (-12.09%)
bpf_lxc.o        tail_nodeport_nat_egress_ipv4          16318      16292      -26 (-0.16%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         18907      18490     -417 (-2.21%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv6         14624      14556      -68 (-0.46%)
bpf_lxc.o        tail_nodeport_rev_dnat_ipv4             4776       4588     -188 (-3.94%)
bpf_overlay.o    tail_handle_inter_cluster_revsnat      15733      15498     -235 (-1.49%)
bpf_overlay.o    tail_handle_ipv4                      124682     105717  -18965 (-15.21%)
bpf_overlay.o    tail_handle_ipv6                       16201      15801     -400 (-2.47%)
bpf_overlay.o    tail_handle_snat_fwd_ipv4              21280      19323    -1957 (-9.20%)
bpf_overlay.o    tail_handle_snat_fwd_ipv6              20824      20822       -2 (-0.01%)
bpf_overlay.o    tail_nodeport_ipv6_dsr                  1175       1033    -142 (-12.09%)
bpf_overlay.o    tail_nodeport_nat_egress_ipv4          16293      16267      -26 (-0.16%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         20841      20737     -104 (-0.50%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv6         14678      14629      -49 (-0.33%)
bpf_sock.o       cil_sock4_connect                       1678       1623      -55 (-3.28%)
bpf_sock.o       cil_sock4_sendmsg                       1791       1736      -55 (-3.07%)
bpf_sock.o       cil_sock6_connect                       3641       3600      -41 (-1.13%)
bpf_sock.o       cil_sock6_recvmsg                       2048       1899     -149 (-7.28%)
bpf_sock.o       cil_sock6_sendmsg                       3755       3721      -34 (-0.91%)
bpf_wireguard.o  tail_handle_ipv4                       31180      27484   -3696 (-11.85%)
bpf_wireguard.o  tail_handle_ipv6                       12095      11760     -335 (-2.77%)
bpf_wireguard.o  tail_nodeport_ipv6_dsr                  1232       1094    -138 (-11.20%)
bpf_wireguard.o  tail_nodeport_nat_egress_ipv4          16071      16061      -10 (-0.06%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         20804      20565     -239 (-1.15%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv6         13490      12224    -1266 (-9.38%)
bpf_xdp.o        tail_lb_ipv4                           49695      42673   -7022 (-14.13%)
bpf_xdp.o        tail_lb_ipv6                          122683      87896  -34787 (-28.36%)
bpf_xdp.o        tail_nodeport_ipv6_dsr                  1833       1862      +29 (+1.58%)
bpf_xdp.o        tail_nodeport_nat_egress_ipv4           6999       6990       -9 (-0.13%)
bpf_xdp.o        tail_nodeport_nat_ingress_ipv4         28903      28780     -123 (-0.43%)
bpf_xdp.o        tail_nodeport_nat_ingress_ipv6        200361     197771    -2590 (-1.29%)
bpf_xdp.o        tail_nodeport_rev_dnat_ipv4             4606       4454     -152 (-3.30%)

Changes to sched-ext:
File                       Program           Insns (A)  Insns (B)  Insns    (DIFF)
_________________________  ________________  _________  _________  _______________
scx_arena_selftests.bpf.o  arena_selftest       236305     236251     -54 (-0.02%)
scx_chaos.bpf.o            chaos_dispatch        12282       8013  -4269 (-34.76%)
scx_chaos.bpf.o            chaos_enqueue         11398       7126  -4272 (-37.48%)
scx_chaos.bpf.o            chaos_init             3854       3828     -26 (-0.67%)
scx_flash.bpf.o            flash_init             1015        979     -36 (-3.55%)
scx_flatcg.bpf.o           fcg_dispatch           1143       1100     -43 (-3.76%)
scx_lavd.bpf.o             lavd_enqueue          35487      35472     -15 (-0.04%)
scx_lavd.bpf.o             lavd_init             21127      21107     -20 (-0.09%)
scx_p2dq.bpf.o             p2dq_enqueue          10210       7854  -2356 (-23.08%)
scx_p2dq.bpf.o             p2dq_init              3233       3207     -26 (-0.80%)
scx_qmap.bpf.o             qmap_init             20285      20230     -55 (-0.27%)
scx_rusty.bpf.o            rusty_select_cpu       1165       1148     -17 (-1.46%)
scxtop.bpf.o               on_sched_switch        2369       2355     -14 (-0.59%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80a9eab79cac..186c912cf72b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1372,9 +1372,9 @@ static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
-static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
+static bool is_spilled_scalar_after(const struct bpf_stack_state *stack, int im)
 {
-	return stack->slot_type[0] == STACK_SPILL &&
+	return stack->slot_type[im] == STACK_SPILL &&
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
@@ -20004,12 +20004,12 @@ static __init int unbound_reg_init(void)
 }
 late_initcall(unbound_reg_init);
 
-static bool is_stack_all_misc(struct bpf_verifier_env *env,
-			      struct bpf_stack_state *stack)
+static bool is_stack_misc_after(struct bpf_verifier_env *env,
+				struct bpf_stack_state *stack, int im)
 {
 	u32 i;
 
-	for (i = 0; i < ARRAY_SIZE(stack->slot_type); ++i) {
+	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
 		if ((stack->slot_type[i] == STACK_MISC) ||
 		    (stack->slot_type[i] == STACK_INVALID && env->allow_uninit_stack))
 			continue;
@@ -20020,12 +20020,12 @@ static bool is_stack_all_misc(struct bpf_verifier_env *env,
 }
 
 static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
-						  struct bpf_stack_state *stack)
+						  struct bpf_stack_state *stack, int im)
 {
-	if (is_spilled_scalar_reg64(stack))
+	if (is_spilled_scalar_after(stack, im))
 		return &stack->spilled_ptr;
 
-	if (is_stack_all_misc(env, stack))
+	if (is_stack_misc_after(env, stack, im))
 		return &unbound_reg;
 
 	return NULL;
@@ -20043,6 +20043,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
 		struct bpf_reg_state *old_reg, *cur_reg;
+		int im = i % BPF_REG_SIZE;
 
 		spi = i / BPF_REG_SIZE;
 
@@ -20070,13 +20071,15 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		 * Construct a fake register for such stack and call
 		 * regsafe() to ensure scalar ids are compared.
 		 */
-		old_reg = scalar_reg_for_stack(env, &old->stack[spi]);
-		cur_reg = scalar_reg_for_stack(env, &cur->stack[spi]);
-		if (old_reg && cur_reg) {
-			if (!regsafe(env, old_reg, cur_reg, idmap, exact))
-				return false;
-			i += BPF_REG_SIZE - 1;
-			continue;
+		if (im == 0 || im == 4) {
+			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
+			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
+			if (old_reg && cur_reg) {
+				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+					return false;
+				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
+				continue;
+			}
 		}
 
 		/* if old state was safe with misc data in the stack
-- 
2.52.0

