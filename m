Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202940;
	b=XK1bx+Tn/z/rH7p+LkRHBUJhe8wCRrUeBjbtVY8YrzhRGorlTIwF5HruS37VGEJMAhN7
	 PHSzliWmW8WwCIe6J6ru8eDKzSluNhk10FAUsnk8VpWtIWsnV4Dm1Vnh6ASjYPtmGPxRa
	 nCw5/YK/Q7Dp9HFIqhigLVsfZTMYHNx7GQ6+7jRqraktcFb8ziJJXizm9GkfBUGImXy7p
	 Hy6SKdB2QmR/fhIjJR1FOiJZSOqkp4suQ9aAgtzbPiEjWIqEagSNOZTiNd2l/KoCr1uQC
	 /A86D6FjMODRFjFboSGmxjFlmjpKEVsEyyPAC00UB8rpRBZroWowVi7+y3k6hO3jh+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=rgOk+2JzcXcdvhwuiOrgUJ3RoFYJfBq7HmoG7i71aIM=;
	b=RC6kJGdszZtAIdYtTqVOmDS5ZfBPJXWuQxUs15yghdi50VOfP3lWF9aikTsdemsZ6SnG
	 LbbtRgnMIVopAWZDz1QzDX8OXijqxH2vy5Z9snsxdxxqM5LP7P+Y66zfcNGjYKqUvV/29
	 5Snp5alFJXib2xWZRDO97o4nq49Kem1PaLik1N9lbo2iXdyEBj28FxRRpHYKObd0DEBYW
	 QDRk+Tug87Wye7Gilwk6Q86SbOpjquMqOEA6oWYF71f/IfZ5Txykd87Mubu1hTQdBoPPa
	 HI3BdjLEHukXFkh21taYfKjekEGsw4Qf5Vzrq6waKBZsGMCyl4eS/fypgu5aQIfZNQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqZwmuds;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C8606A334
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D4C8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqZwmuds
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso840130a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202940; x=1795807740; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgOk+2JzcXcdvhwuiOrgUJ3RoFYJfBq7HmoG7i71aIM=;
        b=hqZwmuds66Kz1JoP7lnnHw7ua6TH3yQY7telnJmM0CpBbbRmzkUL3245A5UsK01B9g
         zK8VB/T22fGevOWKYsREmZapn+uxJl2XP/pqcqNZXNR3rqUscIzzAc5LW7+jnpS6u4So
         /GcA+g0iGAq0A3yKEnuUyCJQT6DXTfjDwQcIEXyExrTKhv3PQgkYVTge+DumUW7LYMzK
         GW1EO9z73e/7K2fqG/KsrWjPigZ4ne8pIkJLrZ3oy0eGTNYL/DJIFKFl3p9ZP29WwFn8
         WI/3RbgeIPNXOXuBnYRfKO/MMVwtUk4k/gFryTnzvi2e2QYdbJlh548RryzJ2Iqz82FY
         Ox7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202940; x=1795807740;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgOk+2JzcXcdvhwuiOrgUJ3RoFYJfBq7HmoG7i71aIM=;
        b=zMkL+A1LKOA3v5gx82OGf3fwAcPgF9vRu1+odeJldy2rTtUJeccl7xxHcQqOKRxXEb
         eA0LVDcrTJlDv/+8K56vFrG5H/xwidRho6ZXD4eBrKHUXuFm2zmm9TDHuNdP/gLHeKsz
         IrOH7cgxCWKpVkO8PJDYs2EsdghXyvdX83G4wRlJa6d0r1te/+7hvdtCfd/TU3D/92Ts
         NFbIfLCfzFiueECuAGsgxMcHtSg9cdaajHN2xH9PFIDTYthLySDcGfP/Krdt/dmnUuSU
         wQl2zcU37AfYZEKrC8kD9IcER/QVN6yvtpBLANwy6LlW4qVB+HD8bv1yc7b2In8FiWk6
         5R1w==
X-Forwarded-Encrypted: i=1; AL+hErEN0wvWAmhILG5DM/mZVfDiX8dVhSb4j4nAPV1dZM7MaVlv9wZw+L8xc1sEIhuqqBS25HA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f81imVxPJBnUFM1Vlg4FlonRBpzz4SLGHU4kkfhnhsPvnTSPG
	w8F43dOY/Wwj+TNgpvT7TvlnUOU56RQwuB32OPqG2R4D7MFmsJBTmOyp
X-Gm-Gg: AZFdTZdoU6DauDmUkLetYVGZyiYhE5j/ymx+kS9xGpso2irJUrKESacTSPUAXP12o6H
	exju1VFdx6cnG1vwWvN3Qpmdxwq1StJb5+IhwNtzFt38u9zkKHYteCwr8g/e1kEwLhjTAAyee/X
	1FKpbd1XRY02UxIMvK9HvdXuQ7whQmw1tiJb92LahQnP5n/bchgK3cozJaiddVP7dygD6WpP9JU
	nP/xk5PebpR7BsxdDozSrdykVuU1cpIzaYcA7bCo1OhLyYgcrhkCdufng9ReTC2XL1qbyT21JY+
	Y5zU292irK8eV+3j/VzhpaOs9K3yQofsmp81bBjhQ9XiPYpkLp25ZxOMIAWFy+wcjudFlBuW74b
	B6v9l0qjoT45k5oHJ6bJmqPPTeAHjkjus/EilNh8MGzMM0H3vfzx4+MmB1Xboea8tN2d4kPIkY+
	2MXG4u0S6QJJRUdjqfLeobTGJa75yujn3U2ok4uqHMFG9mFRFCBeSkn6FdWL+I/wpdrQdvqg0jD
	XefSuorUadsEpUjwgsVVOynXHfePmZ6ZFSpt/GkrUfZpQutJQR/aomR9cvisaddKPZU6XufbQeo
	D3AszXrIW5LbHnRIhnbHtOvZdIG+FflLVtElD0dHYN6HcoxsVWKsy/Vj9V5I6VhMGMSvf5nz/Xe
	r/LeTIbD0TrU0NdbPmkJP23p5Kyu6fmcUfQ==
X-Received: by 2002:a17:90b:2f8c:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b41c92c175mr3762060a91.26.1795202939485;
        Fri, 20 Nov 2026 11:28:59 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm5331002a91.13.2026.11.20.11.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:28:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:28:58 +0000
Message-Id: <DN0ABWWQD6EE.3K5F7Q9N05BCL@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: Fix CO-RE relocations of
 unsigned 32-bit enum values
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261120165545.2074537-1-yonghong.song@linux.dev>
References: <20261120165540.2074139-1-yonghong.song@linux.dev> <20261120165545.2074537-1-yonghong.song@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 08:55 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> The local enum has the kflag 1, so the original value matches the
> ld_imm64, and nothing would warn. So if the target enum has the kflag 0
> but the local enum is signed, take the 32-bit target value as signed
> too. A target value is then zero-extended only if neither enum is
> signed.

That rule is one 'if', but new_val gets there in three steps:

  step                                 new_val
  -----------------------------------  --------------------------------
  1 bpf_core_enumval()                 extended by the target kflag
  2 bpf_core_enumval_targ_is_signed()  sign-extended by the local kflag
  3 bpf_core_enumval_is_sext()         sign-extended by the insn

Another idea...
Keep the sign extension in bpf_core_calc_enumval_relo() as it is today.
Zero-extend once in bpf_core_calc_relo() when neither enum is signed.
Steps 1 and 2 become one function.
BTF_INFO_KFLAG() works in libbpf and in the kernel.
bpf_core_format_spec() uses it already.
The table in the commit log stays the same.
Then no need for btf_enum_value() in include/linux/btf.h, btf_kflag(),
bpf_core_enumval(), bpf_core_enumval_targ_is_signed(), etc.

Instead of patch 1. kernel/bpf/relo_core.o builds with it, no test
was run:

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623..3f37a08 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -887,6 +887,28 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 	return 0;
 }

+/*
+ * btf_enum->val is __s32, so both values are sign-extended at this point.
+ * clang zero-extends the value of an unsigned enum.
+ * kflag == 0 is an unsigned enum or BTF without signedness (kernel before
+ * v6.0, pahole before v1.24), so new_val needs kflag == 0 on both sides.
+ */
+static void bpf_core_zext_enumval(const struct bpf_core_spec *local_spec,
+				  const struct bpf_core_spec *targ_spec,
+				  struct bpf_core_relo_res *res)
+{
+	const struct btf_type *local_t, *targ_t;
+
+	local_t = btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id);
+	targ_t = btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
+	if (BTF_INFO_KFLAG(local_t->info))
+		return;
+	if (btf_is_enum(local_t))
+		res->orig_val = (__u32)res->orig_val;
+	if (btf_is_enum(targ_t) && !BTF_INFO_KFLAG(targ_t->info))
+		res->new_val = (__u32)res->new_val;
+}
+
 /* Calculate original and target relocation values, given local and target
  * specs and relocation kind. These values are calculated for each candidate.
  * If there are multiple candidates, resulting values should all be consistent
@@ -962,6 +984,8 @@ static int bpf_core_calc_relo(const char *prog_name,
 	} else if (core_relo_is_enumval_based(relo->kind)) {
 		err = bpf_core_calc_enumval_relo(relo, local_spec, &res->orig_val);
 		err = err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_val);
+		if (!err && relo->kind == BPF_CORE_ENUMVAL_VALUE)
+			bpf_core_zext_enumval(local_spec, targ_spec, res);
 	}

 done:
@@ -1144,6 +1168,13 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);

 		imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
+		/* GCC sign-extends the value of an unsigned enum. Keep its form. */
+		if (relo->kind == BPF_CORE_ENUMVAL_VALUE && orig_val <= UINT_MAX &&
+		    imm != orig_val && imm == (__u64)(__s32)orig_val) {
+			orig_val = imm;
+			if (new_val <= UINT_MAX)
+				new_val = (__s32)new_val;
+		}
 		if (res->validate && imm != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
 				prog_name, relo_idx,

pw-bot: cr
