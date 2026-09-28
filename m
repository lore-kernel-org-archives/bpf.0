Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DC4908DD
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588355; cv=none; b=VL6moymKEr7BJBt3WzzazDysK6O0w6kvClklwOZbzNVfrLUh0/3vV7uiKbfEpaqnSiX0a6SqdGmvtMLK2ylAvk0HHAc0svVSAA1xXixbfuoA0seKka3gR42fFPk1/IPdiHAwcfsvLweoh0LYTfdSMasGqdXvtJr4NlA6HD4Y6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588355; c=relaxed/simple;
	bh=fPSAkpXceotewOm7SP+DxaTZce1G7lVnPkb26Wo39js=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ5f3097NUSB/UUyVocn89uk1WhNQduLuMsOCHlSW3QSq5YCB7ijKB7PUikwmu8qXu9tZdm+86a6j54u+I5bPrB3OMW4PLYEOtE0LvaAOyHa659ykjCXL1CQYocQv67pHziCdWFUe3xcnGSZQJoTJ/itDM/EdZg0kzBFIPvbdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbT3KQmq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbT3KQmq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so1642566f8f.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790588352; x=1791193152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kNmKaS/yqaPwVbbzT4Ywfn1EK7iiUTlp4oHaPapUKg=;
        b=WbT3KQmq7h/DozQacKqiLYHnhrhuN0icQmSLmdYm3ZTe6Sj2gZgZtLZVFM0LvC+l+f
         cj3VX9aAIRPCkOx+V1/M3Lohr0E2MRx73MtAPHRYbAUghHXHeLsqaM10KTM8/x2C+sI5
         P6knXOOh4DbmOZgT669nF+NXbxRyVvJ6/bVWNuNnfordDwl0RKUgxQ/obWV9+futBEHn
         MktkKdDFVdYKyAokF3R71b0Z9ccNjGO5CpizhKYWxeGRFTxvVTr0/4khnWdqTFOwze4m
         aqjbjxxxZelN+YyV8gDU45SoDheiETYSL7Auztv9qaGLb3N2iqR8MabqXnx5vk0X/1Ge
         U1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588352; x=1791193152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kNmKaS/yqaPwVbbzT4Ywfn1EK7iiUTlp4oHaPapUKg=;
        b=EslUnk5mUpcqiHwPuYMvIcBEpxCY4XmVmH/MBnTHkShY61Ce4tzSdczRsRH2om/5NB
         Fs2UTqbxRTUnZc/geOWw8Xy4EmvpXLlzmbRT5sU3IRc9ilZsZwtAgtCT3HLccT3Y9Zeq
         R2aHLfy5SlWOCXsPiWcUpXeUPHOlJ5R1d6V9mkaiZHFQcFSOWEgJlapJjYMmNkDhPrqZ
         syEjNeX+wTQuTMC8n2/dcs3IbyNnggtb4aknqB4FH2SGHksjO3MIwKhIU0upaGGmx9yE
         AEPupxnVORKrgfvEmqbEy6kt249R9LDvYkFeO0OobI9pgs3TUGfEGHcTVD0nZBvXPuqa
         vToQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQdZ48gBo3bLPGx1jTYM1N2AT2oRrSNJxQabi+ty4b06KnJqFdQ9JkpKNVJDPlrCBrvrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRUJirOdr0B3uzugJQqFGBXK5YBG0CFLw5doycNy4/WJe+QFII
	Wtuqx8iaP3sQKq6XUbcb5bMBLjKcC3lsaIzmZt1IpwwJpCsFu63SyEI7
X-Gm-Gg: AYBFou0ZxnVr+4VikURyUVENWv6YbFWgz9WDBmz9F1iqrSEyXlP/qnJ7Z866Q3oD1pb
	FRW1YoMBlvzj1FHiVfLbFTsPMEYV7+qTFbIDTYD5ZVOC+bCY4q+XXFad//YOlhxqW1IfqwWN2Pn
	HAchhT1pA6ic6jQemEyV3l7aQ+nSb6+/tjNFrzvX05pGhAxQNzz/Hu/m0XQkmUUfRzZriIcRBUQ
	ziUmsdHkWBIAYAVYOuH6tkKtiiE98bAczdVsJIPJ3Xs1QoDkv5W10p1FSu/uwG6N+0F2FnK+ab2
	GiHJl0s6qQZL47LN0w9Wno2p6F1WVJR5FhGMChmKqEGBPXWT0Ii+i/mybxg7tZYkxdnhJPdebQN
	DbZRh74oAWxpX7hW7QCMqOIVGdpejCKW/xxY33Wk+NS9pPIOEgtpBvXvzTY3tIIxeLtcFCjV+xN
	ZRZivuGkpfa+N+/5kRtBaNFB73SBwEHDpXhVmtwukVk9JBOxxgiaOm2xN35w==
X-Received: by 2002:a05:6000:2212:b0:488:8132:141b with SMTP id ffacd0b85a97d-48881321757mr14347747f8f.20.1790588352050;
        Mon, 28 Sep 2026 02:39:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm25764743f8f.37.2026.09.28.02.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:39:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Sep 2026 11:39:09 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
	daniel@iogearbox.net, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
	nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
Subject: Re: [PATCH v3 bpf-next 2/3] bpftool: Update func representation to
 include function signature
Message-ID: <aro1veHZThxBJbhF@krava>
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
 <20260926175113.2368566-3-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926175113.2368566-3-alan.maguire@oracle.com>

On Sat, Sep 26, 2026 at 06:51:12PM +0100, Alan Maguire wrote:

SNIP

> +static void btf_locsec_func_str(const struct btf *btf,
> +				const struct btf_loc *loc, char *str, size_t sz)
> +{
> +	const struct btf_type *func, *func_proto, *loc_proto;
> +	const struct btf_param *params;
> +	const __u32 *loc_params;
> +	const char *name;
> +	__u32 i, vlen;
> +	size_t off = 0;
> +
> +	if (!sz)
> +		return;
> +
> +	str[0] = '\0';
> +	func = btf__type_by_id(btf, loc->func);
> +	if (!func || !btf_is_func(func))
> +		goto invalid;
> +
> +	name = btf_str(btf, func->name_off);
> +	func_proto = btf__type_by_id(btf, func->type);
> +	loc_proto = btf__type_by_id(btf, loc->loc_proto);
> +	if (!func_proto || !btf_is_func_proto(func_proto) ||
> +	    !loc_proto || !btf_is_loc_proto(loc_proto) ||
> +	    btf_vlen(func_proto) != btf_vlen(loc_proto))
> +		goto invalid;
> +
> +	params = (const void *)(func_proto + 1);
> +	loc_params = btf_loc_proto_params(loc_proto);
> +	vlen = btf_vlen(func_proto);
> +	if (!btf_locsec_append(str, sz, &off, name) ||
> +	    !btf_locsec_append(str, sz, &off, "("))
> +		return;
> +	for (i = 0; i < vlen; i++) {
> +		const struct btf_type *param_loc;
> +		char param_str[256] = {};
> +
> +		if (!params[i].type) {
> +			/* Handle varargs func proto, must be last parameter */
> +			if (i != vlen - 1)
> +				goto invalid;
> +			if (!btf_locsec_append(str, sz, &off, i ? ", " : "") ||
> +			    !btf_locsec_append(str, sz, &off, "..."))
> +				return;
> +			break;
> +		} else if (loc_params[i]) {
> +			param_loc = btf__type_by_id(btf, loc_params[i]);
> +			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
> +		} else {
> +			snprintf(param_str, sizeof(param_str), "<unavailable>");

hi,
I'm getting many unavailable arguments, like:

jolsa@krava4:~/kernel/linux-qemu-1$ ./tools/bpf/bpftool/bpftool btf dump file /tmp/vmlinux+inline | grep func | grep '<unavailable>' | head -10
	func='cpumask_test_cpu(cpu [reg0], cpumask [<unavailable>])' func_type_id=171851 loc_proto_type_id=171852 offset=7674
	func='instrument_atomic_check_alignment(v [<unavailable>], size [const 0x8])' func_type_id=171855 loc_proto_type_id=171857 offset=7681
	func='instrument_atomic_read(v [<unavailable>], size [const 0x8])' func_type_id=171858 loc_proto_type_id=171857 offset=7681
	func='variable_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171860 loc_proto_type_id=171862 offset=7681
	func='arch_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171864 loc_proto_type_id=171862 offset=7681
	func='_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171865 loc_proto_type_id=171862 offset=7681
	func='__srcu_read_lock_fast(ssp [<unavailable>])' func_type_id=171867 loc_proto_type_id=171868 offset=7691
	func='srcu_read_lock_fast_notrace(ssp [<unavailable>])' func_type_id=171869 loc_proto_type_id=171868 offset=7691
	func='class_srcu_fast_notrace_constructor(l [<unavailable>])' func_type_id=171871 loc_proto_type_id=171868 offset=7691
	func='__srcu_read_unlock_fast(ssp [<unavailable>], scp [reg3])' func_type_id=171873 loc_proto_type_id=171875 offset=7727
jolsa@krava4:~/kernel/linux-qemu-1$ ./tools/bpf/bpftool/bpftool btf dump file /tmp/vmlinux+inline | grep func | grep '<unavailable>' | wc -l
157950

I found on the pahole site 

  /* A zero id in LOC_PROTO represents unavailable location data. */

so I guess it's just not present in dwarf for some reason

jirka
