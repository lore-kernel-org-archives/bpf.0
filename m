Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74A35979
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232654; cv=none; b=ZPWErxNJM3VkC1aWCGqUUY+pb/HxAr7wCI3sbJwAFe7h2VzbMstIPveHWnPSkee6lcUBNnAmd+k50mhm4ukVTyalGXeHp/7mgy7uFVfHFcrXq+zk5rVgmkWiSPWd4p3yLSEUDrtyliol0Fn66UPfq8bLNpn1Seyo+h/QCY+u4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232654; c=relaxed/simple;
	bh=XCDw3oQH52VeVdqJcY2TtTAWeCkVK5mCXdYgF39EEIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhq4wbnkvPInf+bpFENuFidOvQjnhkkdJjg0LdMEHzqH58mgxBk3FUq2sRd4cHQgL3RhP9tujH1vmxjfDGyGd8U5XNeoneOnwZqEDb+oiein+ox1FHCmP86eZ6l+hB5t9E9/xN2679djxGH4E7NwSYMLVgug1kugRaPozJapudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlTqRIQj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlTqRIQj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a27414a3so1370608b3a.3
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774232652; x=1774837452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWeuVWtAqhFJmHKrwks1d3KoeMaW4sARTJdLceX4vHE=;
        b=HlTqRIQjFMt1mG66WIXfwdPp5yyFj63poIjcUUWKEMSjXm0cXvhWhhYWQJIrWdUjo7
         DZscEuOLAWXJR9nUzE387iyVyx1aYpipUHXqVM/Yze4uIUelPi3cXoUszBFOou5mfPik
         cd9R7+c+KlKl3ju8AeCiGEucPdHFzdNtyG7+bmnQ9GEN3nAMsENZ09bgO6WjaliMsX3n
         4d/tvWXzr3ePVnqQ1lWt7J5Yur1IK8Lh5Hk2ld3sWC1FfjB9RBRZ8I6FNGInBVwfWcYO
         To3awtdSNW2GnGnrVh6nlzbwc7hHu8vO0aGiJE9dXdL2YxsG1jxiE2jD4lRS5ewgbelk
         Lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774232652; x=1774837452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWeuVWtAqhFJmHKrwks1d3KoeMaW4sARTJdLceX4vHE=;
        b=OKbVyBcsWY7ahikLpMtZ0u15uuu56Ihp22BmThixnw6Iw3EFrP+f5ulRerHXwf+kLs
         SUllrm/4UStVfnM6OAGIeV3CGttebrIG8hQQhsdpIOGE01CuDMrxmocB0fMwZPx6SGlH
         kpGtsMU1NKbq/tj+zn0zKXv/6BSjVEeTwnD/x+ceCzcheLZxqBYhHU6NnoB9pMCGemCQ
         bm3lleKV4NzBOBMZ/MrDr8EU/xN76Hf3ygMN/L7/VM80k4QXuh7RtrXzrjh1+8hia0Nl
         YRUoE+abSdZuzrB6qJYY1W3QedhFUrU/jEktkDhgtDizZc3puhYw0QzFzF5LqHSVCD4i
         L8ZQ==
X-Gm-Message-State: AOJu0Yy4x8MNJpLkb/ZpgFGIFlxJZ0mP4NHrugUxs8Xp0Yd1/d/mlq2H
	u2cThwl39tcxr05p9DVrxUFCMUKRi0B22ESKHxv244BMt9dAPXX4INgQOaB7uQ==
X-Gm-Gg: ATEYQzw/IAJwhebNvPB1QGIEIQtZBElCQH6rqTlQV+yS2xHoiROavne5MaxW+2V8UoC
	tbQNV5ppLTFVLYRDPsZ28U6BoP2bt23RC+8vlooYLHRzPk9LY5lN45XcSuhQ3UwuNa/+G2Ccggh
	hSCXIqUDgwvhKZMiZSVHkVtuG1Xxel99SHiZaIw92r5OqUerkoiBcOtx2DBPluX/BvD724Dt6OO
	CePZfro9+MaXfxTH79eEd4TMj/gGnqNHQFFHJzCnBs1r5F9GzT6viAfAM1eb76r3ZYZwyIo8ML3
	8RUsiFmiZ8EcAppqIXI4wD3Y6jR33Ab4uSPvyfYTHTJBnQCf8cHGAHLVH5TidYtz5SRCMI7Wz1X
	7V+SW6UnnummzyRtdYei8xxTeVYs12Yy6SI4uJHv/a58u7d8ov+h4Kxji8NTXKXjq+FW89DJW1F
	JqmOlkWyFi2leKR7LO6OIZsZAdAmllW9Jk0Tvw+xytnPBDguF3AZFYP55ZzqCGzPBKmuLnddhxe
	9Rb7LUHmShwNhgSdfxJgvjCxmO8lQ+pB0NFOZ2ao3Y6oQF7MCgBltWRIvzVTQ==
X-Received: by 2002:a05:6a00:3919:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82a8c285a94mr8859190b3a.24.1774232652306;
        Sun, 22 Mar 2026 19:24:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6745sm7981220b3a.23.2026.03.22.19.24.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 19:24:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 1/2] bpf: Support 32-bit scalar spills in stacksafe()
Date: Sun, 22 Mar 2026 19:24:09 -0700
Message-ID: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
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

v1->v2: updated comments
v1: https://lore.kernel.org/bpf/20260322225124.14005-1-alexei.starovoitov@gmail.com/

The commit 6efbde200bf3 ("bpf: Handle scalar spill vs all MISC in stacksafe()")
in stacksafe() only recognized full 64-bit scalar spills when
comparing stack states for equivalence during state pruning and
missed 32-bit scalar spill. When 32-bit scalar is spilled the
check_stack_write_fixed_off() -> save_register_state() calls
mark_stack_slot_misc() for slot[0-3], which preserves STACK_INVALID
and STACK_ZERO (on a fresh stack slot[0-3] remain STACK_INVALID),
sets slot[4-7] = STACK_SPILL, and updates spilled_ptr.

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
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80a9eab79cac..528d2a030265 100644
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
 
@@ -20065,18 +20066,21 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (i >= cur->allocated_stack)
 			return false;
 
-		/* 64-bit scalar spill vs all slots MISC and vice versa.
-		 * Load from all slots MISC produces unbound scalar.
+		/*
+		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
+		 * Load from MISC/INVALID slots produces unbound scalar.
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

