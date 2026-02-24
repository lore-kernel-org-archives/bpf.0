Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042D86329
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966028; cv=none; b=eNwQmbcs0b3J5Fr2ekPWcaoRCRMPo+oDdiTy4AKguAWLvgpPNns9rffo2GARU76L3j4vU4+E3nPhXymXAwyBnlZAKlkSuczHQKBnH/2Dh0Vg7ytxWU/qq2vyhHXDYzfsuvlJESgs4CqX6EQvlMVBQRDOJO8U4H8b1rZWeNc3Y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966028; c=relaxed/simple;
	bh=bali7a8Hh+sN8T1hv1aQW38KsoJrfKcnpFUBjx/IXhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiODgfo5HukC/xsBs5ynXYz6AqTAGSDseYYGl09LZ6DwC2D6iFiuOBEoH3ue0W10FJjWqNhyBgqmmD1Ub6QzLENZX5JODkhuYUo2w5NBrYh7XlobEhqdOOnlMhIeS0JrQoLfZ8ZERc9JzjOHxwAN4lbg/8u1jBW2nzWfmkKL+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIiYnGRH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIiYnGRH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso1246565e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771966026; x=1772570826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2RY/jAMzJnGRiPq5Y2oi/XXXyC/s1g5i3jX8zBq+lg=;
        b=lIiYnGRHztvScsPxoDMwOrQ5JakAmXTD3+8l/4bVe90WhTyIpn8709It8jr4uw4h4V
         dzJVwKeMhEle0EWz8p/iUMLUYObTaznIkIkZ1Xbb7cPZBf33YwRHWvhXSApKS6yo9Ade
         ziIFNlRN51ooL3ArQYFZ2Q4pyd7VncvEI97OmhBnsOcnokGqHoJMC9l6NOUgxCMRxGVt
         Xz/8YCVH36UgmC7OtTP7VaGT3pkrIkDddzbJyMS7/p3HJrw4pkzCrljgM/9hxUW5HZgJ
         tOZVH/a9jC9IomLwmsoRoEirQ4lgFYVhAQhlE8jcVPdXM4YTQoqV8A/l4CTh9JQDcjxv
         ziBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771966026; x=1772570826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2RY/jAMzJnGRiPq5Y2oi/XXXyC/s1g5i3jX8zBq+lg=;
        b=he3Zg/PhtM2kVwI4E55kdqcsppMdrLk1xK5PeaE3iUWwnYaYv3WoZ2n7y0Eh3HWQ9p
         sLKXdZlyqlgDY6txp8fDdf8OQ19wJdctpT7tcH/FwdnpiY3CO1hbA7z71bzSi0kkRdjw
         ptPYjOLg4jImSFFz0sFztm8DhBKKGjCynkh3T4tWK6Ct0nljWlqF8lLPolPo5vtcl0ry
         wA99c5wn1HZSgAIYXaDl8QJCkN+cgpKsDa1KwU+ztBmi/PkJ1x32W17Sfk3FVeTXQ9FE
         /VPg2Cwgg+xCmxoAPFKAGrEAZDVQWEXE3+VqtFwctOJYYtoRZ2tuaThxITX5FgnVIArm
         nSXA==
X-Forwarded-Encrypted: i=1; AJvYcCW4bVJrZSZXYBI7Do1ORXJOfHQlPdf9OeiFdAgvaagMJtsJBkLzqICPt7wNHvCYMTmyhk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgB0K9H3BFXqwvH3p7uc7Gs4Jnt5pMpUz1tEvz6zarcRl+0Gbn
	Dw/em7Kna6KiOmzOIxnNIat3UxEZpMlfvaTlp8Bw5UWpF4Bnu7SzN4gB
X-Gm-Gg: AZuq6aIAmm/OEowGO8fLL0309p6d1hSSwl2BJRDDju7hW0Q/d6OCHjxP5FO8PP9N3jD
	PIZmL8l0e6YhbTHo1vqKyuSpCIPWVbKnteWnURn1NuZv7SSdU/jqudJyw0oY12cN6T8QNBm3+Zh
	s87xrHPNNfUTaktw0pY9TgWs5OFb+A9BG3Ns34iNutC32+lOeEazjA+aAuZQLbaLu+lcg97TyUa
	hvHej4ImZEkCcLjPSd4mnFj5LXOGBIzqqqkyaqNr7GvcLmgELdAO8/2rQW2ydKRebM2IMaJ/Xix
	Uh92Mx5LlEUG7uGuVIlN318yxknGHkyaCC6cz/isYVeilCsmPsUjGHSGephPjjaCfrOACEq8g0t
	EUSmzg8LTIy484WLT81iRejZ3feMej2skWc6Px8nloDJSlKsWXKfYRypop4WwbeA72HWARDrS5I
	n2Ggn1dXOte/jSwjPN7E/u8zIeQILpPCcMGuwHD2+k/7s+UWsvsJOoKnwnLv+TUHM=
X-Received: by 2002:a05:600c:3e10:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-483bd7429a1mr20460815e9.11.1771966025387;
        Tue, 24 Feb 2026 12:47:05 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:14a2:8a3a:807e:d6d? ([2620:10d:c092:500::6:ed07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm28373558f8f.13.2026.02.24.12.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 12:47:05 -0800 (PST)
Message-ID: <f9ed274c-30bd-4967-b57c-ed0b2873407e@gmail.com>
Date: Tue, 24 Feb 2026 20:47:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
 <83cf0430bf164c46abe56d2ec6565ca57ead1663.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <83cf0430bf164c46abe56d2ec6565ca57ead1663.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 19:28, Eduard Zingerman wrote:
> On Fri, 2026-02-20 at 11:18 -0800, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add bpf_program__clone() API that loads a single BPF program from a
>> prepared BPF object into the kernel, returning a file descriptor owned
>> by the caller.
>>
>> After bpf_object__prepare(), callers can use bpf_program__clone() to
>> load individual programs with custom bpf_prog_load_opts, instead of
>> loading all programs at once via bpf_object__load(). Non-zero fields in
>> opts override the defaults derived from the program and object
>> internals; passing NULL opts populates everything automatically.
>>
>> Internally, bpf_program__clone() resolves BTF-based attach targets
>> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
>> func/line info, fd_array, license, and kern_version from the
>> prepared object before calling bpf_prog_load().
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 82 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..4b084bda3f47 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
>>   	return prog->line_info_cnt;
>>   }
>>   
>> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts)
>> +{
>> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
>> +	struct bpf_prog_load_opts *pattr = &attr;
>> +	struct bpf_object *obj;
>> +	int err, fd;
>> +
>> +	if (!prog)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (!OPTS_VALID(opts, bpf_prog_load_opts))
>> +		return libbpf_err(-EINVAL);
>> +
>> +	obj = prog->obj;
>> +	if (obj->state < OBJ_PREPARED)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	/* Copy caller opts, fall back to prog/object defaults */
>> +	OPTS_SET(pattr, expected_attach_type,
>> +		 OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type);
>> +	OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach_btf_id);
>> +	OPTS_SET(pattr, attach_btf_obj_fd,
>> +		 OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd);
>> +	OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd);
>> +	OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags);
>> +	OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex);
>> +	OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: obj->kern_version);
>> +	OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array);
> It seems 'fd_array_cnt' is not copied, should it be?
>
>> +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_fd);
>> +	if (attr.token_fd)
>> +		attr.prog_flags |= BPF_F_TOKEN_FD;
> Nit: should this be 'if (OPTS_GET(opts, token_fd, 0) && attr.token_fd)' ?
>
>> +
>> +	/* BTF func/line info */
>> +	if (obj->btf && btf__fd(obj->btf) >= 0) {
>> +		OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf));
>> +		OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL) ?: prog->func_info);
>> +		OPTS_SET(pattr, func_info_cnt,
>> +			 OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt);
>> +		OPTS_SET(pattr, func_info_rec_size,
>> +			 OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size);
>> +		OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL) ?: prog->line_info);
>> +		OPTS_SET(pattr, line_info_cnt,
>> +			 OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt);
>> +		OPTS_SET(pattr, line_info_rec_size,
>> +			 OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size);
>> +	}
>> +
>> +	OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
>> +	OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
>> +	OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> Just curious why did you decide not to inherit logging properties from
> the original program?
> Unless overridden, the original program would point to the buffer
> specified for the object in bpf_object_open_opts->kernel_log_buf, right?
Inheriting the object's log_buf here would mean writing
into a shared mutable buffer, which sounds not very good,
I don't see where this scenario is useful.
>
>> +
>> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
>> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
>> +		err = prog->sec_def->prog_prepare_load_fn(prog, pattr, prog->sec_def->cookie);
>> +		if (err)
>> +			return libbpf_err(err);
>> +	}
>> +
>> +	fd = bpf_prog_load(prog->type, prog->name, obj->license, prog->insns, prog->insns_cnt,
>> +			   pattr);
>> +
>> +	return libbpf_err(fd);
>> +}
>> +
>>   #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>>   	.sec = (char *)sec_pfx,						    \
>>   	.prog_type = BPF_PROG_TYPE_##ptype,				    \

