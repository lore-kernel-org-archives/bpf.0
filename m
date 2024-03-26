Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20013C817
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464483; cv=none; b=b1OI+n905S8o7FIeCPgFsyvuV9CUqLWuLqsa6Z6sNPthIKPGe3kkSMwIl+XGAy0nYRqmmu3hneBuQJXpnF+cAYPBPL+hyXJG6h+uP/aaH4s5BQV+wiRqorhtblq0C2D5fx7K+EVFyaxAy2ddRNP1FSHuHvJjNSICyc9TwzosziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464483; c=relaxed/simple;
	bh=3PhPFmtMXTFzXulo7OnKGBtbp3soH+jEYdIaqNsLrJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFelOFUwlslCglK0uto0GZDbjM3rnLKkHXZVkIqaCNGIgiP4tlD9XyFFhvUrfS6tF4gm2V2bh7hi1UaCgjwf5HAMYEbBNg1dAyrima3o3wwL3/qamspSRCYyqMtG+VuxRZ59ucq65XlSxMHW48Q4HoSqq7OY9rLqY1vVz/aKdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig07/6NJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig07/6NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711464479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jScJXT7RWmrSuuM+GEL3DawWsowDb68KJFR/IcMnJKM=;
	b=ig07/6NJBmZL2if7EwGXHR7sPiWXPH7npCgqkCqgjpya6vwUdKRctuw0CRbNZta8i7Lmpi
	T1nHecCam/GTasuHKbfwuLLzer3Ec2iEFZDaBGvKjb5kf2g/xztKUYd/i22qEOae8tYm/o
	FfipRYIl4hwwuFnThMTc6v8Qt59ZwbU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-rRj36WOXNpq7FWVnlG3Bug-1; Tue, 26 Mar 2024 10:47:58 -0400
X-MC-Unique: rRj36WOXNpq7FWVnlG3Bug-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-515a8e9bea9so425345e87.0
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 07:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464476; x=1712069276;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jScJXT7RWmrSuuM+GEL3DawWsowDb68KJFR/IcMnJKM=;
        b=O09jOTannwcIT0vv8xTjrO/67ExqdVxyd7IvT9SNFa08nMQ2B6iWM2lKPE4yl2W3qB
         bt2g5IBQQsa/E+pKIUyMQi+kUtotVD7h2k/ZqzoxXYpGUhkJiIkSxT5P6WYj8ATM4L9o
         Kk/lrP1N7CHV2F8LlU7+kXDi+M3JY/DEJ5RpsohmM5VATo2WWUOg6HkvI2PS1fq+TY3H
         w6qdI2Mmmq85w1OiJ6VVfLXad6Noh+p26zv62RsUP0fBXsus0CCfBOZn5NJV6IOWWSn+
         Em3+0uGvCpONqMkGsH1g1Z2wZl6xhIwuk+YMx8brZ397f+5EiAnQT18Kqj847JCtUH96
         Jo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAq1mJ8FAl+pfIdino1lW3CbnNtexrjmjTibYvw8a+siW+q0WHJ5mlmT3T46Yg3NiWd3BdsBkMnafcnTe0mJoN6eNp
X-Gm-Message-State: AOJu0YyxrEDOAgt65hYnQcHxp3P6XN79RAaGG8FF0u63ivBgmKmA4/L+
	BrNffnexeTm6yrlDAthZt0k1rMkqIUkPbiDh1AybHCphTN0yIIDbkooGuZDgOfcCpAr2asS9wug
	gsjWu/eGAUygmuCjy806cmwNn0Sqg76aGB6rQfSyBX1WsZpAsfg==
X-Received: by 2002:a19:8c52:0:b0:513:30fd:2991 with SMTP id i18-20020a198c52000000b0051330fd2991mr5763249lfj.0.1711464475947;
        Tue, 26 Mar 2024 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATkY2AHLmAtWCgq6Q66TQl3TnOeEqIO0zVH4UI6gJ3Hh5NT81qC9HaNonp0FQderrY/k4tg==
X-Received: by 2002:a19:8c52:0:b0:513:30fd:2991 with SMTP id i18-20020a198c52000000b0051330fd2991mr5763219lfj.0.1711464475437;
        Tue, 26 Mar 2024 07:47:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id k1-20020a170906a38100b00a4644397aa9sm4300119ejz.67.2024.03.26.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:47:54 -0700 (PDT)
Message-ID: <ea2ad0773c91709094764474bf46825c146d741b.camel@redhat.com>
Subject: Re: [PATCH net-next v13  06/15] p4tc: add P4 data types
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
 khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com,  pctammela@mojatatu.com, bpf@vger.kernel.org
Date: Tue, 26 Mar 2024 15:47:52 +0100
In-Reply-To: <20240325142834.157411-7-jhs@mojatatu.com>
References: <20240325142834.157411-1-jhs@mojatatu.com>
	 <20240325142834.157411-7-jhs@mojatatu.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 10:28 -0400, Jamal Hadi Salim wrote:
> +static int p4t_s32_validate(struct p4tc_type *container, void *value,
> +			    u16 bitstart, u16 bitend,
> +			    struct netlink_ext_ack *extack)
> +{
> +	s32 minsz =3D S32_MIN, maxsz =3D S32_MAX;
> +	s32 *val =3D value;
> +
> +	if (val && (*val > maxsz || *val < minsz)) {
> +		NL_SET_ERR_MSG_MOD(extack, "S32 value out of range");

I'm sorry for the additional questions/points below which could/should
have been flagged earlier.

Out of sheer ignorance IDK if a single P4 command could use multiple
types, possibly use NL_SET_ERR_MSG_FMT_MOD() and specify the bogus
value/range.

The same point/question has a few other instances below.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int p4t_be32_validate(struct p4tc_type *container, void *value,
> +			     u16 bitstart, u16 bitend,
> +			     struct netlink_ext_ack *extack)
> +{
> +	size_t container_maxsz =3D U32_MAX;
> +	__be32 *val_u32 =3D value;
> +	__u32 val =3D 0;
> +	size_t maxval;
> +	int ret;
> +
> +	ret =3D p4t_validate_bitpos(bitstart, bitend, 31, 31, extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value)
> +		val =3D be32_to_cpu(*val_u32);
> +
> +	maxval =3D GENMASK(bitend, 0);
> +	if (val && (val > container_maxsz || val > maxval)) {

The first condition 'val > container_maxsz' is a bit confusing
(unneeded), as 'val' type is u32 and 'container_maxsz' is U32_MAX


> +		NL_SET_ERR_MSG_MOD(extack, "BE32 value out of range");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int p4t_u16_validate(struct p4tc_type *container, void *value,
> +			    u16 bitstart, u16 bitend,
> +			    struct netlink_ext_ack *extack)
> +{
> +	u16 container_maxsz =3D U16_MAX;
> +	u16 *val =3D value;
> +	u16 maxval;
> +	int ret;
> +
> +	ret =3D p4t_validate_bitpos(bitstart, bitend, 15, 15, extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	maxval =3D GENMASK(bitend, 0);
> +	if (val && (*val > container_maxsz || *val > maxval)) {

Mutatis mutandis, same thing here

> +		NL_SET_ERR_MSG_MOD(extack, "U16 value out of range");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct p4tc_type_mask_shift *
> +p4t_u16_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
> +	       struct netlink_ext_ack *extack)
> +{
> +	struct p4tc_type_mask_shift *mask_shift;
> +	u16 mask =3D GENMASK(bitend, bitstart);
> +	u16 *cmask;
> +
> +	mask_shift =3D kzalloc(sizeof(*mask_shift), GFP_KERNEL);

(Not specifically related to _this_ allocation) I'm wondering if the
allocations in this file should GFP_KERNEL_ACCOUNT? If I read correctly
the user-space can (and is expected to) create an quite large number of
instances of this structs (???)

[...]
> +void __p4tc_type_host_write(const struct p4tc_type_ops *ops,
> +			    struct p4tc_type *container,
> +			    struct p4tc_type_mask_shift *mask_shift, void *sval,
> +			    void *dval)
> +{
> +	#define HWRITE(cops) \
> +	do { \
> +		if (ops =3D=3D &(cops)) \
> +			return (cops).host_write(container, mask_shift, sval, \
> +						 dval); \
> +	} while (0)
> +
> +	HWRITE(u8_ops);
> +	HWRITE(u16_ops);
> +	HWRITE(u32_ops);
> +	HWRITE(u64_ops);
> +	HWRITE(u128_ops);
> +	HWRITE(s16_ops);
> +	HWRITE(s32_ops);
> +	HWRITE(be16_ops);
> +	HWRITE(be32_ops);
> +	HWRITE(mac_ops);
> +	HWRITE(ipv4_ops);
> +	HWRITE(bool_ops);
> +	HWRITE(dev_ops);
> +	HWRITE(key_ops);

possibly

#undef HWRITE

?

Otherwise LGTM!


Cheers,

Paolo

