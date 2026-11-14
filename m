Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794690434;
	b=dJbekKbh1+TlFLqwcbFd7S51r/KPenN/KI38swU1a1x+QY/wFBzY9RF4MPGfjE8FQQej
	 SnsPraFXlD/6NmoYDDH/mriuHCUEQ1pvHcvcGSLD06rt67wX5/gEqnzPEarDZDBdzN1g5
	 Xg6kft49OvrfZQWO811XWssYxhW2NVRFcKcwKZB3OyUHAx7Wzb+EQLwcrf83kGhYVYRL8
	 f8MRIPGXtH3QsLpy1uD+jvSxOXarWnTsMfq/6AfC+Q9qytc6BOlt/Uan+anI76cUjMpee
	 TDIomRFefQZp8eZXydSR4HdzlqaBIKc1f15w3upT4hkAXanBJJHQz028vi5UL8JbOjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZspwZPH2kKSALvwqhcLsdGFEbLQ7Rp1Tu7Ygz0wgQug=;
	b=45bvaKPDMKa0ngGbKC6KZx0sji9yX1kqUoHT/D/ocK9UmjbK2oIyRkGrHK43xwQeC1bc
	 MiHszfPi3Wb//J3AUuGn5JEI9puiLVZCBaiiurcN4FHdat+PPV133EEBXy3gztpNEzq2d
	 vIHD4wG08eZzNdxW0xMjwwP+XcnC9wIApPo+ih39koZLOfHXAb6cXszE+wId/y0gT2X6E
	 Opp1bmYa7ln3zW8eH1c8f3VwfZ6J1dQJuZpO9bM0UjHsCsjBy2V6oUu++w8qouWJgU+J/
	 lCWulmWOzwSjrUHCQ6FnLJo8sNoOzYOxOQs4nin0n20HL1LpDqi0jx9//ocQf/6PXBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bwzlucdx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD25606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 21:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bwzlucdx
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f1e3dd08cso8796256d6.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 13:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794690433; cv=none;
        d=google.com; s=arc-20260327;
        b=DeKxPhJoOQ/MnOhJlysYfan3SSbVxPIVQHGQtdCxEMJMCL3kuBDw/0WR+CIho5m110
         KGPSpO/MLEiEpG0QtsLRy444sMb7xRFUyUIc9zhsQ8ZtySDqfFGyrfVxY88oVdqx60A+
         IQ7E3OOls/ijjMs+j09RYw/XjPWeZFW4iq4gBqfLa3s6PMnTl0bz25chR82ht24frHz6
         eJCXPMVNs1oEEDU1KKg32/8kAJ2FZOs3xOtZAbgTxBsDJfaR16AVxSlacFMX2n9JlMrd
         YPzwKLI/GD2lBpKOw4oAXsVY6Svs1u0q+zMpmCo1h5YUuqtWhgwX08YaRg41V77QwzXu
         50lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZspwZPH2kKSALvwqhcLsdGFEbLQ7Rp1Tu7Ygz0wgQug=;
        fh=GheExqJTH7N6zcLIqNH/G2Vw6y/RVk0i0QD0zEdvWA0=;
        b=Pa7r7VZ+Oxi3uUfEVmEpwHq5b/+KWbeNY8Igy/4JB+Lxf9j3TUlYC8anAsgKkzg9Pn
         oEdxLqbRz7HEguujWlxOEJndSn6vOYbPS/5Qbfqas6ls7dNN/fpcg2rbM+CRO+7DPiBF
         GPJ5WdKxjNVkgURlFg3WjcuJiAL8k3XwvRsieYtG3u4EOHYZZaNJKPyBSUmWS1ag4m5z
         57+xoH+XgH2mIoN7RIsoMe2I+X8QMoZNo9HtAvABATF8mSiB5xOQfEO/njaGIJYoqtuI
         bknB7OIGkrpuvAnRd6ZwfeX0yBvzUPLnB422Z629YUVGdS1NOWV3iAzCeUkEZjghMCKD
         kPjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794690432; x=1795295232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZspwZPH2kKSALvwqhcLsdGFEbLQ7Rp1Tu7Ygz0wgQug=;
        b=BwzlucdxMBQA42GQk8oRp9/l60mKl6l4qdq6aE3wZLorUjR2ihW4qZQb1G7XwSWLJP
         3F7M8ywyOZ1jm88ywNCcnyrqL0bgMA/s/nwrAcehrJ8uxkHlVza+0BkiiYLsG3u32wfi
         iIXtReZVVwEQLZGeX+ruBY+jQuUie5Td4bmiO22DR3japLrTtoo/RJNcNVZpcYg6M/PQ
         PWvEJtwiOWm0EOHgwi21+cE3bAjwbGXJA1tpLzJDoG4bLnG0ifgXaQJT0uxNRNlSEBVC
         JIHunU365d2QH2FTccsFWXR12HG5xtNq2UGBso+Mmodn0FLxeGjF4G4FqcNmMemvV+wg
         N4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794690433; x=1795295233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZspwZPH2kKSALvwqhcLsdGFEbLQ7Rp1Tu7Ygz0wgQug=;
        b=Qf4Y4CFt6DqUIlPxBz5GjjS6WHvHWi7FPWcP4VrgXb6M+vlCc1THuo81BkPQDK/iIQ
         M2i75/XuzAYbxyR5yzr7n53+cEBkMSpbI7B20uSyVvOz2ox7c3ihiA0WIvBBYHJkAwg/
         YI2DPqqVSD6XjyuN7TCR+5FXaICoNx1YZIVvWqQYwEREkMAmiLmessdjrxqqts8RiDdS
         8YBXZ2EdKjp3pE2DO8b3lztFlvUsFeHXhG40IhV0d0j6B5UU9ohjmXJ9V/TdjtGAOtJ1
         jwi5TlsONM2dKNNDC5V5rV9scTufHEcf6w0xOuDuBh3gUbYR9K8M5fEICHzOluH7T2YK
         Dlnw==
X-Gm-Message-State: APuU4Z+fdVUdnOyT4eQ8KgpqmJjLLY+gSsqXD0Hs4nCM1FGSBUqZC7dA
	NqD+CAzm7QVpxmmXrjBFxJr8MlhKBNwm0srnvebtGGm/l1lvzEPPkbJRa/Uh1r/x8UJsM74mq93
	Mdxx/MajkNNcVPRIZIAoXhXsOiwVNhcU=
X-Gm-Gg: AYBFou0YEjf+rt9nShyCfjhh7pd09vzGQjgs1lIQOudRhz+5QAtD3vEAsE0lc4Pl0Bs
	LWwsyKr+TJpTHZo5ce4mhOBQP60G4oym681K/258dHEpSe5zaEA92HHAGs0+nwB3wC0VjnJa3P+
	DlBO+Q1QmNQVJnB/0iDsK093kDt6jgSxKmfCWAEqIXA14aGwd4ix94vLYo/YXJRfqFIGAFQ/e9k
	bx3CWbg+Cf1Fw5Tt9xlPt31/WELMQgsP96wXu+fND95nGeQF+ubBTvZNGTtOfAoF6iVH/LSdacB
	KA+1MZ9FbgNo8Q5rA32ti/veqRU0irCE1bVIOc0qi2LWqgB/o34ouM82eX64l96dpLy4QdAdJqc
	c3A+eFcCd/EoN58861shi9124BpzHouALjs253qQ+zawhw7UwTeyvQS517hAXOkpT8eRUOCUO7y
	MJDLGO1gogdUg6
X-Received: by 2002:a05:6214:2461:b0:91c:6258:ec97 with SMTP id
 6a1803df08f44-91f2418f879mr105727516d6.11.1794690432637; Sat, 14 Nov 2026
 13:07:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
 <20261114051805.683966-6-alexei.starovoitov@gmail.com> <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
 <DMV78SSW0U92.LH9TAXR0MZ5O@gmail.com>
In-Reply-To: <DMV78SSW0U92.LH9TAXR0MZ5O@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sat, 14 Nov 2026 16:07:01 -0500
X-Gm-Features: AclHuK-EXUGAF4xjW8m-7aHew0d0kEKcQVV5HY7eskwSr3dRIGUolskgYASUdqU
Message-ID: <CAEXv5_hR=RNzwqYB=q=X_CiYSq6E2if6YaS1TiVU4LMvzfnmNA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions that
 return errors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, a.s.protopopov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 14, 2026 at 11:37 AM David Windsor <dwindsor@gmail.com> wrote=
:
> > Do we also need -EBUSY here as an exception? crypto_enqueue_request
> > uses it to mean the request was queued on the backlog (not that it
> > failed)
>
> Good point. -EBUSY is not a failure there, -ENOSPC is.
> A prog that returns -EBUSY skips the list_add_tail().
> crypto_wait_req() then waits for a completion that never comes.
>
> In most other functions -EBUSY is a plain failure, so means_failure()
> can't drop it for all.
> ccp_enqueue_cmd() and qat_alg_send_message_maybacklog() have such
> a backlog too. All three also return -EINPROGRESS.
> So drop -EBUSY only if the function returns -EINPROGRESS too.
> crypto_enqueue_request() stays a target with -ENOSPC.
>
> Here is proposed follow up... other ideas?
>

Looks good, selftest looks right.

Other interesting edge cases my bot identified:

1. bit_wait() in kernel/sched/wait_bit.c returns -EINTR to report the
status of the waiting task, not to indicate failure
2. try_mem_charge_cg returns -ENOMEM, but callers might not be set up
to handle it, it can be masked by __GFP_NOFAIL. Such callers won't
expect an error there.
