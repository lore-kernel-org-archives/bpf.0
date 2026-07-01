Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F843637D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903778; cv=none; b=b/9C3Nfpgl+SmEGR4caJo269OKx64dtDvJ3sNr1Fl2KrntbpdNweQJtkFkrpEyseBfQaAzEvk0TvGWxG5SafP6CFiV2qEtWNNzRUwKJoerKFqiGFEFrwK+RlTTJUnhOsFtjloAjc5YJ+7lm0Hj2lNgxwJ3PQgFUkD5gQNwYvyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903778; c=relaxed/simple;
	bh=fRGiZtTZwPpQ+e62B55nkzc896Y8lcB1tI5y3I/MMEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIL7MVqPLn/qie/S7W7mjxcgv/va+XGqcff1SwZcS1O6RC/5n69uP+WwZsqLc9AwGpQwjJYufwT5Ur6BnfvH0cJyfWL7+3MaguVYayd3VobF+CJL5qYhrnwiw0hW24n7qefL+bB8lIJAPl7EFIuHVrIG9onF9JYZIbUqsXKnrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBBSvDjt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVlhmPBb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBBSvDjt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVlhmPBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782903775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
	b=LBBSvDjt6fqmoL5JEZmxIpa+A3xuVgYvXj+mhbHe7y6r6D3W4kbVZuxbTJlo1PLI8aku81
	eAz1an6iVf3vefwLHWfMPYdD38dk6E07byXFT5MQpfZxOGpwklVOmmnshrYcrw8E9F2oPP
	CxuUl3uiW4hWU0GAjzd5qJ0PgqhxNCE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-zYG6qyZ9P-qMBnpoVhGqXQ-1; Wed, 01 Jul 2026 07:02:54 -0400
X-MC-Unique: zYG6qyZ9P-qMBnpoVhGqXQ-1
X-Mimecast-MFC-AGG-ID: zYG6qyZ9P-qMBnpoVhGqXQ_1782903773
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49244130073so4281255e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782903773; x=1783508573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
        b=iVlhmPBb+7k3Oe8KP9Kuo4PtvFA/amoJy/Roa6Li2TUU85OxztmbFdgUYhvobwqSMf
         dfI3UoYJ4Ni/uLB6V8RfQ3kyECcKr+TC717efOlkGT7bSIEKtYvlVKneF9I4oGBv2Haf
         jOJsz9lIRQ2M2lVV8X3LIV9t76TqCHQTOFNTIt801FEYriIAKIZ3FnHE4PMupeVCb+Eq
         NdwuzoaCYfyecxr+KaNRPYdx1XL8DMZNeCZhWB5+tlvlW8rnm8t6meEKG1RZiK/q6ZL0
         CqWuVLrPPWMyDQRY4HnmUKwk9+zou93XO/SV/7uaY1xVWmFIkyiDYVNmTLJed2CTYzT0
         9F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782903773; x=1783508573;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
        b=iihZlAhtH880z5R+lAgzbBft50BWr6tWOYKAf8SGu6Y2JF3gBiuixHWJvjSM7BcYqI
         cq712l8k4v3+aUqYwZtUq/tQE7RCmuYUQJ+BGkpS9mYIxiKcHawIMCAGgD36IdCk0xmU
         +8Ys4dFKU3OaeXDBPlHw9kzdgnMw7omnzNTwFNsiqeqS6Y7S287mpiTKOflKOCdcIwLH
         vPVEhhuhrwFqjeLFGqEDEkgfGvDHRf5GFBK7DH5bgIhh8Qi1V/5Dp/zWGDKldWUQwamy
         WTW7JZ3yj11vtj4M7NxlRiiEn1943/QfbSnq9gFIYtUnQ1nT+FLpFXpyqd7zpaYIueNe
         XhDw==
X-Forwarded-Encrypted: i=1; AFNElJ/y3yzLUvmQB7lUD5nE6YC3/MXqdecoLRmPYyQ/zRtGiHCa5eFE/PGnw6Q7mLlB2ph/iHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Rm4GGEiAdyqzpFreazGEn4eh7n3KAluDyT8tZf3hZORdAE+l
	d/hgUk2mT2n2vGNy1LqWMaot88TjZLhiR/AnzNKtGGopSmK0To4diUZp9azrdC7qpX1QqP+96b+
	Mh5RnuWjzqJ42rBOzht30DpArRBp4YxTKGPREAfmnU6Uz5KucqiR+mA==
X-Gm-Gg: AfdE7cmOJ9wpCFyLHLJbBipFEpoatvkTIc+m8+PBePerGi+Hu/bUoidE48jbBzJ/Saj
	o8lpXOraWqmj/0Wqr5prpfc3dygJflJwrkZyYdc7qSdo9PXB7hXoI23aPd9l7Gc2GlxVgjgU7fd
	8iTUaxz+ODhmrXHHn3bmWnFtF8te/GLh+R71ciI13tTiYaj/Pkg+p/ymc3Yh+AXBm9XZs2q9aLy
	WFhOjPGlQT15h2GX6+aquXzAV0j+KgIQ2H1m3+r7g7TijL5Tn71i0/IbCMRshhaHuYu7/xr2/oA
	PFMFsVKftO3zB/gj4PaWRhx6pUklJVYtVUrkkLM8mbESvJ4+kZ6Vv6F6OAcFSbznfaizjGgq9m6
	2A6gxYDZyJH4ZAjRitDlD/9rvK0ylkGA79Ghh+w==
X-Received: by 2002:a05:600c:5297:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493c2b93614mr16386045e9.26.1782903772801;
        Wed, 01 Jul 2026 04:02:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5297:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493c2b93614mr16385385e9.26.1782903772259;
        Wed, 01 Jul 2026 04:02:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d8f5asm99969285e9.8.2026.07.01.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:02:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9C78480A7F7; Wed, 01 Jul 2026 13:02:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org> <874iik2ew4.fsf@toke.dk>
 <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 01 Jul 2026 13:02:50 +0200
Message-ID: <87y0fv0y79.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 6/30/26 10:04 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> David Ahern <dsahern@kernel.org> writes:
>>=20
>>> On 6/30/26 4:00 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> It does not make sense to require a flag to get lookup output. vlan
>>>>> proto of 0 is not valid, so it is a clear indication that the vlan
>>>>> output parameters were not set during the lookup.
>>>>
>>>> Okay, so we could just unconditionally set the VLAN fields, but if we
>>>> start rewriting the ifindex that would be a change of the existing
>>>> behaviour that could break existing applications, no?
>>>
>>> Consistently dealing with upper devices is one of the reasons I never
>>> sent patches for vlan support.
>>>
>>> xdp support is at the driver layer for real (physical) devices. The fib
>>> lookup is going to return the vlan device index - a virtual device.
>>> Support for xdp should not be propagated to virtual devices; it goes
>>> against the intent of xdp. Any trip down this path will have to decide
>>> how to handle vlan-in-vlan use cases. Where is the line drawn for fast
>>> networking?
>>=20
>> Right, which is why we need building blocks that makes it possible for
>> XDP programs to do the right thing in the BPF code :)
>>=20
>> A helper that resolves the parent could be used for stacked VLANs as
>> well (just calling the helper multiple times).
>>=20
>>>> Specifically, if an XDP application has a table of the interfaces it
>>>> forwards between, today they'd get a VLAN interface ifindex, which wou=
ld
>>>> not be in that table, and the application would return XDP_PASS. Where=
as
>>>> if we change the ifindex and populate the VLAN tag, suddenly the
>>>> interface would be in the table, but because the application doesn't
>>>> read the returned VLAN tag, it will end up sending packets out without
>>>> tagging them, leading to broken forwarding.
>>>
>>> I have not followed developments over the past few years. Does XDP have
>>> support for vlan acceleration in the Tx path now? You really want that
>>> to deal with vlans and not replicating s/w processing in ebpf.
>>=20
>> It does not, no. There's TX metadata for AF_XDP, but VLAN support is not
>> in there (see include/uapi/linux/if_xdp.h).
>>=20
>> Doesn't mean software VLAN handling can't be useful, though; there are
>> use cases other than the very high end where XDP can speed things up
>> even if it has to write a VLAN tag or two...
>>=20
>>>> So if we don't want the flag, we'd need some other mechanism to resolve
>>>> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, sa=
y?
>>>> That could also be made generic for other stacked interface types, I
>>>> suppose.
>>>>
>>>> WDYT?
>>>
>>> dealing with stacked devices is hard :-)
>>>
>>> What is the return is a bond device or a vlan on a bond device?
>>=20
>> Well, bond devices have XDP support, so you can just redirect to those :)
>>=20
>> But yeah, each type of stacked device would need to pass different
>> information through to the XDP program, and the program would need to
>> support those. Building a single XDP program that supports all of them
>> will require quite a bit of code, and would probably not perform super
>> well. But most deployments have distinct subsets of features they need,
>> so this does not have to be a blocker, IMO?
>>=20
>
> Seems to me the fib_lookup for xdp needs to return the bottom device,
> not the vlan device, for forwarding to work. That's why I added the
> fields to the struct. That allows the program to push the vlan header if
> required. My preference (dream?) was that Tx path had support to tell
> the redirect the vlan and h/w added it on send.

Sure, returning the bottom device index with the VLAN tag makes sense,
and that's basically what this series does (but bails out on stacked
VLANs). However, that's not what the helper does today, which is why the
flag is there, to opt-in to the new behaviour. I don't think we can just
change the ifindex without breaking existing applications (as noted
up-thread).

> But really, once stacked devices come into play, I just wanted to make
> sure thought is given to different use cases. As you know the lookup
> struct if hard bound to 64B and it is trying to cover a lot of use cases.

Agreed, I don't think we can handle stacked devices in this helper. But
we could split it out into a new one. Something like:

struct lower_device_info {
	enum device_type type;
	struct {
		__be16	h_vlan_proto;
		__be16	h_vlan_TCI;
	} vlan;
        /* add other types here */
};

int xdp_get_lower_device(int ifindex, struct lower_device_info *info);

called like:

int xdp_program(struct xdp_md *ctx)
{
        struct lower_device_info dev_info =3D {};
	int ifindex, ret;

        ifindex =3D find_destination(ctx); /* does fib lookup, or something=
 else */

        while ((ret =3D xdp_get_lower_device_info(ifindex, &dev_info)) > 0)=
 {
        	if (dev_info.type =3D=3D VLAN) {
                      	push_vlan_tag(ctx, &dev_info.vlan);
                        ifindex =3D ret;
                } else {
                	return XDP_PASS; /* we only handle VLAN devices */
                }
        }

        return bpf_redirect(ifindex, 0);
}


With a helper like this, we obviously don't strictly speaking need to
change the fib lookup helper at all. However, for the single-tagged VLAN
case, I think supporting it directly in the fib lookup could still have
value, as an optimisation: it saves an extra call for resolving the
ifindex, and the fields are already there. So I think my preference
would be to merge this series as-is, and then follow up with a new kfunc
to handle the stacked case. But we could also just drop this series and
go straight to the new kfunc.

WDYT?

-Toke

