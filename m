Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5762192F9
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005414; cv=none; b=BTNwMFJ1ms7JmIH+HR4YwRcrRD9IjFmlXHgawD7QuoSwSarPFF9Gat1fzgYOy9vc0h9U8D3BUkVWkdv0xSE5rsBH2cDFnaBKCQXc1DUz7ZYptAuwoL+Pf7ci4UgOk+/kOxdAUT9V2dq7hA9op9p+NtwvRiV4xwdMVSlCper1bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005414; c=relaxed/simple;
	bh=LyjMsSur0mF4LFYlncoNUGDu4SH4x4Hjg6dId0uBtP4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=nXMNt1q0wGOgBCVosyRiJRbkNVjLyd+xDFq7WRGbNXp1/2L3FMB8op9/ddrv3ik1D8k2MndtJY+POSE+Ktk91O/g/4j0FZvDpk9qSSG+hE3OdrkIf3zDUdyMU+biPWqvNStLzdl/JD+5BqQ1SAkvfEamvdbz2+TT+OH2AzXABA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ea9pdqBV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DldW6vyB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea9pdqBV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DldW6vyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769005410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LyjMsSur0mF4LFYlncoNUGDu4SH4x4Hjg6dId0uBtP4=;
	b=Ea9pdqBVKBrpVwcetv1y9trOT0jj/RfYWXVccYJZVvCxDUjdIEYaLMh2ERn1lQK39OXjhh
	n33tR/LHIZ9kYmMtUSS86gEj51D1LJYfzzfUV14/HUqyay2D3KaG+WQHRgtNpTBBWjnkvS
	8azx+wOzjsrrmNy/6GvN14iDw5DJxik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-XKnTBMlWMRC93ZaCcu98rg-1; Wed, 21 Jan 2026 09:23:29 -0500
X-MC-Unique: XKnTBMlWMRC93ZaCcu98rg-1
X-Mimecast-MFC-AGG-ID: XKnTBMlWMRC93ZaCcu98rg_1769005408
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso4348138f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769005408; x=1769610208; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyjMsSur0mF4LFYlncoNUGDu4SH4x4Hjg6dId0uBtP4=;
        b=DldW6vyBJmj5zlSCuODXYZkjJufIzlbGkqcO1T/KXPWfQSZc1CPG06pAKcEDuudjqu
         S1hVfBSeY+EH36fBgQJs/6DRQzgMy0sMzCgv8ZmwImOzZTL2x7KszDLPeJjDigqYoXSB
         TuYYYaI6Sw3HG4ngJwTZyOxYjuAiTnRs3BZ12klm4pqHn+FN8eJscge7rxmn9tPo4aOs
         oatKmJGqzey2q7+rfuZzRvebUPuVZ3uEpNlGHQV5hWWQKFYtyWbU3+WCG22ZNl/2pkw4
         MmQRJiwrs8yGhcb/BpnNjuzTRlEUlmS6fENvUYfN72TT6uTJ67OHC47fay7IO92cmjA1
         5vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005408; x=1769610208;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyjMsSur0mF4LFYlncoNUGDu4SH4x4Hjg6dId0uBtP4=;
        b=Sxx+IxbLjkrYYqzl+SJlz1ThLlyzb/DptjSXO2VDKeb9/xYmc511F1dDXfcmoRbGti
         omo+zKSfspydh/ZWFpULEhnldk/7wHtrzMgnp60PMM8hRDp3rkGsHbvq8DQ1XN8Zcg2Q
         RcpoTFe8ojlsKsv7CJoe7/VBRcQMeP3npO4jQ+ZEtUTbtetpYx8qiZDTrzht/wsREQ1r
         bbfnrFf5ObbzF8jRs3mgPLcnphlzsLul2RRq6EH1P0FR+n2NFF/NxLN2Ol7JUBVODLbo
         qZuuTpmaL7Sv43ht6Hp9DTnljaEX21/ya9XR0kYIe4SvXQtsJGpzMOwbhU0FG9i9qbU9
         PjzA==
X-Gm-Message-State: AOJu0Yxep5HWwWK0dBJsVfy3hOPYlMJDxXLpYe9iuK9rHXDrb3uMhdlP
	s+UCYbmjEsUF7uFFpkwM27az3Gb8pkvtWCTQKS+UjYRU1U5c2bAtPqIvPJHvzUeKjmZd3RUlDQI
	UX2OK5fgDOZVjSC/+UPjEZ/9v3Ki38WVdKYlQy5P3woxZWXOZhPZ4jlZ2YpRg7fAokVc6WpI/82
	VQ0Z1CrNw9nPMozOyJUUGWagwHUmDKRzvW1g==
X-Gm-Gg: AZuq6aINGamSf+QLyfnwYGFXhTpIrCMRogQ5Wl2Vri2gNNpfRuHvsKjJsqwGpmywVBv
	loor6OmCVYwdT69s2b1TIwm/agHxW37r5v69QauTu2ubDosCZW/a8HSqcuWIldCMYVDoJwHRSY2
	CNV7xgJBQbmOTMei5hh9nfFLzRiI0TkbvVY52nKgPHEExklGi5uQUxLX8bV6kYHMQQf/bgx6yVc
	LEQi2Mu8t7epTke7ZRiZnuINOYgtQdiA1lZ3Ce6jC06dphHXn6SsEzomcZB5ODR6t96k/42TT9O
	DxGfwT6oJBncr3CJcUi84D91lAcekmCZaEZpgT9TNn6e1FeeJGAwePZRXGAiJFjxfE4hGHVk7dH
	qQ+6WvSryDYHpie/uDBJcF3qcHtWviqdVRfnDQ+OJHa7E
X-Received: by 2002:a05:6000:1842:b0:432:852d:5662 with SMTP id ffacd0b85a97d-4356a072156mr23678595f8f.63.1769005408051;
        Wed, 21 Jan 2026 06:23:28 -0800 (PST)
X-Received: by 2002:a05:6000:1842:b0:432:852d:5662 with SMTP id ffacd0b85a97d-4356a072156mr23678545f8f.63.1769005407488;
        Wed, 21 Jan 2026 06:23:27 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm38235305f8f.6.2026.01.21.06.23.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:23:27 -0800 (PST)
Message-ID: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
Date: Wed, 21 Jan 2026 15:23:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>
Subject: [RFC] selftests/bpf: Running test_progs with distro configs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I know this has been discussed multiple times already but I'd still like
to open the topic again.

We struggle to run BPF selftests, especially test_progs, on distros
whose configuration is different from what is in
tools/testings/selftests/bpf/config. While the tests usually compile
fine, many test cases fail because some required config option is not
set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepable
tracing programs, which is often not enabled on enterprise systems).
This makes processing the tests output much harder.

One possible solution would be to maintain our own DENYLIST but I can
imagine that the same problem affects other distro folks. So, I'm
wondering if the community would be interested in some solution which
could live inside the upstream repo. Obviously, I don't want any
complicated solution which would require a lot of maintenance and would
bit-rot over time. So, I'm thinking something like introducing
CONFIG_DENYLIST which would contain "config:testcase" pairs and a couple
of lines of code to test_progs runner which would parse the file and
automatically skip the given test cases if the required config is not
enabled.

Last, let me briefly mention our motivation. BPF selftests are
practically the only comprehensive test suite for kernel eBPF as well as
for libbpf and bpftool. Running them regularly on distro kernels can not
only help find bugs in distro kernels and packages but also reveal
upstream bugs which are not caught in upstream testing (b/c we test on
different arches, different hardware, etc.).

Before staring implementing an RFC, I'm curious to hear what other
people think about this.

Thanks!
Viktor

