Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626033815D8
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783142; cv=none; b=Jxh7laChZf4fsN3hjfHL50XO4pK344sx0s6QYWuUHdFHMaSXYHHd16Eatxlir7A2PJzecLl3RHoIT2Em9zm8pWdHGHLXQyQAF+zTIQIIsvFCxMXYyxwUlXc3qNCZkULGIzfhXr+XVOrc5lXWjjc5Wb6+u9M6bp/uTgv4i7k0FzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783142; c=relaxed/simple;
	bh=7GFIGS8nTaICIrcF0Ku+hXoe9VESh+Q8OTbnmMzJkwM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU7vKJgTMCgUerEHLBUwZ7ujViSCekgVSpeF94JHviRCXBA3QRrtp0V3daGIYWurDCmcneXIbS5wok9uTjcOzYYcm9g0HXZZq7aJ+s/sO6+xdTBOX67UvyRuQuCWIKqbwB4nfYoH3wlEN39Stw1hPI4SKvrZuG7g05L1VO/nEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsF72jyr; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsF72jyr"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e320322edso26153366b.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783131; x=1791387931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnuX1SOtp6v3Zz5dNVeJKCigck4bUGAuwqKalsntj8Q=;
        b=IsF72jyr6kTxff68qEOqRwWT2JtDj2vnshir6IKgIMy5DmMAfG9NlYMxx/Uk3rFpru
         EAWOxNMD3lXodhF+blRVU4Cwq3aydKlpn3A3YPe2B1dLf3PZwY0MHnrk/k0v/2GOnjia
         vXf57d6KlMyRe6XpAcIQTp+pnxl18dlhN3o09UQ0pZJQ7nDV9GAg2pIyaTLNhXw9f68Z
         S/MyTqUjLFCwGi/w3nJkv304TacEZ8q43Rg2CjLzgzCmF5OA6dCn/PsB0uSGbmlUiDiQ
         ZuBT3g+hAgI3rL2VQt9h5HljVytYq587HWEvq1P0MbIDW9vvx437PKndFSHK97+wdEFH
         BzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783131; x=1791387931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SnuX1SOtp6v3Zz5dNVeJKCigck4bUGAuwqKalsntj8Q=;
        b=hp7noRdx2Mot++67QUY8KT9am57YM8gwYkOCshYiQdd/FNrDy6y6mzht9rvofxoOT3
         RzEoTwMtYpavlRXfe8BKs/zReEI/bpmYuGLX/Pa4DBCOlNzlUFPbSFIazhZx5FlMjChK
         0oVOgpMEOC6q8uvf1HvH8h4qWuRYsw+Lzit+SWlsYEvc4IE2Ytr3S7sizvgv/3Mv1M8z
         xc2VMZ3YUrF9ty3Wj8+2k5gI2nx+IR+Jww6G70ZLplX4BiA7JAi9Hu+kl6cr9Nl8LiqQ
         HVPlZLy7owenT2FyGEtDC4stw2bUgolHwoDhhEG7ICLFYxES3gtxdX0kAKvB0wRFT5PI
         CgWA==
X-Forwarded-Encrypted: i=1; AKwUvBz0JNP0C/9l/NGGdAKA+OBIVthhGgqkbYYKfDr3Id1M0b7MmxDAEeyYTJ9z5HZ6ZAa6SKI=@vger.kernel.org
X-Gm-Message-State: AFuF++lbJ49aUrBlXxrllSLRAL+A9FBpWMQOw67wl7k3v1KeGuZCYYYA
	n0iHlj9TTPSdIrnRX4sCczS9MyvQD357wnLhdZ14PBXGiaq4TDEDEBeo
X-Gm-Gg: AYBFou0eoIl4fBeq9/JyugdRu2HZrTxg7zTfSW2APmTw8iDE81P0lCiACgztkyIhbk1
	Uxo2VMdS+thgSoiIpUqkLiIIa9hpYw7Xf2amumm2qjiauTBb396Q6GoNeclY1Qk/kcFydQhpBNw
	a6Zw3ONZnodFViuUFmkxEb0Q2PF/UPYKtR7ZA7Be15LvSWjK+buLzw9c2TsLYzwKFf1DtYQByUE
	Yu43izXwOekWOLExbShwoef+noOKPmNT6dF4e/BW9MqRE7VwOewmBiG54jG8Gq5J5uy/cBq0cX0
	LJtBQQ1+2WnEuYfGeZbRq9rq/3drpdmSjW5qu3Z7aJEmjj/osz1ZzcCalxEXqDGusOrI2j/MkfR
	qjVNct1/7u5OYxq1tQxA+lbp4dKLbvApUv/1z0+hA1V/lacAWPR3nMC3kknybZ7z+GtfvX+l9Bo
	WTW37x3875pySTxuYFIgvNQ8n/1ndFdxBcyoMpMjfKfp6v+vw3PL7/1wC1Tw==
X-Received: by 2002:a17:907:969f:b0:c2e:42e:4da0 with SMTP id a640c23a62f3a-c2e23ce67ebmr160109666b.19.1790783130831;
        Wed, 30 Sep 2026 08:45:30 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31dc751dsm27611566b.67.2026.09.30.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:45:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Sep 2026 17:45:28 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v3 dwarves 1/9] dwarf_loader: Add parameter list to
 inlined expansions
Message-ID: <ar0umERDiFj2sN3W@krava>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
 <20260925185200.1318067-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925185200.1318067-2-alan.maguire@oracle.com>

On Fri, Sep 25, 2026 at 07:51:50PM +0100, Alan Maguire wrote:

SNIP

> -static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
> +static int die__process_inline_expansion(Dwarf_Die *die,
> +					 struct inline_expansion *exp,
> +					 struct lexblock *lexblock,
> +					 struct cu *cu, struct conf_load *conf)
>  {
>  	Dwarf_Die child;
>  	struct tag *tag;
> +	int parm_idx = 0;
>  
>  	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
>  		return 0;
> @@ -2957,6 +2965,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  	die = &child;
>  	do {
>  		uint32_t id;
> +		bool add_to_inline_expansion = false;
>  
>  		switch (dwarf_tag(die)) {
>  		case DW_TAG_call_site:
> @@ -2975,13 +2984,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  				goto out_enomem;
>  			continue;
>  		case DW_TAG_formal_parameter:
> -			/*
> -			 * Inline expansions can have their own formal
> -			 * parameter children duplicating the abstract
> -			 * origin's parameters.  These are not needed
> -			 * for type reconstruction — skip them.
> -			 */
> -			continue;
> +			tag = die__create_new_parameter(die, NULL, lexblock, exp,
> +							cu, conf, parm_idx++);
> +			add_to_inline_expansion = true;
> +			break;
>  		case DW_TAG_inlined_subroutine:
>  			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
>  			break;
> @@ -3010,6 +3016,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  
>  		if (cu__table_add_tag(cu, tag, &id) < 0)
>  			goto out_delete_tag;
> +		if (add_to_inline_expansion)

could we just check (tag->tag == DW_TAG_formal_parameter) instead the
new bool?


> +			inline_expansion__add_parameter(exp, tag__parameter(tag));
>  hash:
>  		cu__hash(cu, tag);
>  		struct dwarf_tag *dtag = tag__dwarf(tag);
> @@ -3032,8 +3040,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>  	if (exp == NULL)
>  		return NULL;
>  
> -	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
> -		tag__free(&exp->ip.tag, cu);
> +	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
> +		tag__delete(&exp->ip.tag, cu);
>  		return NULL;
>  	}
>  
> @@ -3115,7 +3123,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		}
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
> +			tag = die__create_new_parameter(die, ftype, lexblock, NULL,
> +							cu, conf, param_idx++);
>  			break;
>  		case DW_TAG_variable:
>  			tag = die__create_new_variable(die, cu, conf, 0);
> @@ -3562,75 +3571,103 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
>  #define tag__print_abstract_origin_not_found(tag) \
>  	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
>  
> -static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
> +static void parameter__share_state_with_abstract_origin(struct parameter *parm,
> +							struct parameter *oparm)
> +{
> +	if (parm->has_loc)
> +		oparm->has_loc = parm->has_loc;
> +	if (parm->has_const_value)
> +		oparm->has_const_value = parm->has_const_value;
> +	if (parm->loc_const_value)
> +		oparm->loc_const_value = parm->loc_const_value;
> +	if (parm->loc_stack)
> +		oparm->loc_stack = parm->loc_stack;
> +	if (parm->loc_reg != PARAMETER_UNKNOWN_REG)
> +		oparm->loc_reg = parm->loc_reg;
> +	if (parm->type_byte_size != 0)
> +		oparm->type_byte_size = parm->type_byte_size;
> +	if (parm->passed_in_memory)
> +		oparm->passed_in_memory = parm->passed_in_memory;
> +	oparm->first_reg_fields |= parm->first_reg_fields;
> +	oparm->second_reg_fields |= parm->second_reg_fields;
> +	if (parm->true_sig_member_name && !oparm->true_sig_member_name) {
> +		oparm->true_sig_member_name = parm->true_sig_member_name;
> +		oparm->true_sig_type = parm->true_sig_type;
> +		oparm->true_sig_type_from_types = parm->true_sig_type_from_types;
> +	}
> +	if (parm->optimized)
> +		oparm->optimized = parm->optimized;
> +	if (parm->unexpected_reg)
> +		oparm->unexpected_reg = parm->unexpected_reg;
> +}
> +
> +static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
> +						 struct ftype *ftype)

could this be added in separate change? seems like it could
ease up the readability a bit

>  {
> -	struct parameter *pos;
>  	struct dwarf_cu *dcu = cu->priv;
> -	struct ftype *type = tag__ftype(tag);
> -
> -	ftype__for_each_parameter(type, pos) {
> -		struct dwarf_tag *dpos = tag__dwarf(&pos->tag);
> -		struct parameter *opos;
> -		struct dwarf_tag *dtype;
> +	struct dwarf_tag *dparm = tag__dwarf(&parm->tag);
> +	struct dwarf_tag *dtype;
>  
> -		if (dpos->type == 0) {
> -			if (dpos->abstract_origin == 0) {
> -				/* Function without parameters */
> -				pos->tag.type = 0;
> -				continue;
> -			}
> -			dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
> -			if (dtype == NULL) {
> -				tag__print_abstract_origin_not_found(&pos->tag);
> -				continue;
> -			}
> -			opos = tag__parameter(dtag__tag(dtype));
> -			pos->name = opos->name;
> -			if (pos->idx != opos->idx)
> -				type->reordered_parm = 1;
> -			pos->tag.type = dtag__tag(dtype)->type;
> -			/* share location information between parameter and
> -			 * abstract origin; if neither have location, we will
> -			 * mark the parameter as optimized out.  Also share
> -			 * info regarding unexpected register use for
> -			 * parameters.
> -			 */
> -			if (pos->has_loc)
> -				opos->has_loc = pos->has_loc;
> -			if (pos->has_const_value)
> -				opos->has_const_value = pos->has_const_value;
> -			if (pos->loc_const_value)
> -				opos->loc_const_value = pos->loc_const_value;
> -			if (pos->loc_stack)
> -				opos->loc_stack = pos->loc_stack;
> -			if (pos->loc_reg != PARAMETER_UNKNOWN_REG)
> -				opos->loc_reg = pos->loc_reg;
> -			if (pos->type_byte_size != 0)
> -				opos->type_byte_size = pos->type_byte_size;
> -			if (pos->passed_in_memory)
> -				opos->passed_in_memory = pos->passed_in_memory;
> -			opos->first_reg_fields |= pos->first_reg_fields;
> -			opos->second_reg_fields |= pos->second_reg_fields;
> -			if (pos->true_sig_member_name && !opos->true_sig_member_name) {
> -				opos->true_sig_member_name = pos->true_sig_member_name;
> -				opos->true_sig_type = pos->true_sig_type;
> -				opos->true_sig_type_from_types = pos->true_sig_type_from_types;
> -			}
> +	if (dparm->type == 0) {
> +		struct parameter *oparm;
>  
> -			if (pos->optimized)
> -				opos->optimized = pos->optimized;
> -			if (pos->unexpected_reg)
> -				opos->unexpected_reg = pos->unexpected_reg;
> -			continue;
> +		if (dparm->abstract_origin == 0) {
> +			parm->tag.type = 0;
> +			return;
>  		}
>  
> -		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
> +		dtype = dwarf_cu__find_tag_by_ref(dcu, dparm, abstract_origin);
>  		if (dtype == NULL) {
> -			tag__print_type_not_found(&pos->tag);
> -			continue;
> +			tag__print_abstract_origin_not_found(&parm->tag);
> +			return;
>  		}
> -		pos->tag.type = dtype->small_id;
> +
> +		oparm = tag__parameter(dtag__tag(dtype));
> +		parm->name = oparm->name;
> +		if (ftype != NULL && parm->idx != oparm->idx)
> +			ftype->reordered_parm = 1;

looks like we could end up with wrong argument index if the dwarf
info is missing for the argument, my agent is suggesting this fix

it gets me over 16k changes like this:

-0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [const 0], struct pt_regs * regs [%r14])
+0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [%r14], struct pt_regs * regs [const 0])

I tried to validate one against dwarf info and it seems
to be correct with the fix ;-)

thanks,
jirak


---
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 49a88d526d9e..d0fb8fda08cd 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3867,8 +3867,15 @@ static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
 
 		oparm = tag__parameter(dtag__tag(dtype));
 		parm->name = oparm->name;
-		if (ftype != NULL && parm->idx != oparm->idx)
-			ftype->reordered_parm = 1;
+		if (ftype != NULL) {
+			if (parm->idx != oparm->idx)
+				ftype->reordered_parm = 1;
+		} else {
+			/* Inline-site parameters may omit or reorder children;
+			 * use the abstract origin's position as the slot.
+			 */
+			parm->idx = oparm->idx;
+		}
 		parm->tag.type = dtag__tag(dtype)->type;
 		if (ftype != NULL)
 			parameter__share_state_with_abstract_origin(parm, oparm);
