Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A25339873
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769063906; cv=none; b=uCbBxNYReg7j+3UBGFp9bZGK3wbXdFvnP6yC+sbeEqkilHU/bPQpEtDcVx0+Wu/YHW97ONLYXol04aqc+G9yZWxfXUUbFhYrJldMSObLqCbLwsRO7CXnp8784zNYAqFRtM61EBgvLqLfQZaDtipdq21d8KSqcrwv6ieyYAtS/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769063906; c=relaxed/simple;
	bh=0q+vFCCmGFHSToRilDqm+twGBLXifbnSxLbadT7x5as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlUQ+MLNp5nwckPvz4fyMCXg77Ghn8E4JXjKtrX34zLyzZIaiJmuR6jZ/ExCSfl/7j3yEaPsdi7YOfxPstIe9+VoFN75TkoAnDkrIWYbU7dP7I795VoDAiQQ8351utpHxLNdGrEHM9V7k6Bnzzh1BNwKlVePX9wJon+dbcoU7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECZZ0dZB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pWcpbtpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECZZ0dZB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pWcpbtpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769063901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQx7O5NghLYNBkSA5AvG3G9IxYGMgWQ49DFOfMxithw=;
	b=ECZZ0dZBR05E69EsOJiLQetlvTJs8uJx5npBV/obBGhlRR5eWtlDUzpQDAuL91tL6xFDEE
	Yi0J91Lkw4zQQ85jgXpNBWaPfSOIy/IFZzh84iS1sQ/jUi0VD55haFhqEYAT2lnqnYZknp
	AIM87EGGUmh8Vt6liGCO63NIXmBTjls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-7i1fwv9VPbiyzXwbhok3-A-1; Thu, 22 Jan 2026 01:38:19 -0500
X-MC-Unique: 7i1fwv9VPbiyzXwbhok3-A-1
X-Mimecast-MFC-AGG-ID: 7i1fwv9VPbiyzXwbhok3-A_1769063898
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso5296145e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 22:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769063897; x=1769668697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQx7O5NghLYNBkSA5AvG3G9IxYGMgWQ49DFOfMxithw=;
        b=pWcpbtporuSnuupx2YlG5IHi5BuKw1Rw3WBfoY0QV8YPJkEkHR2HgJPvOaSs5HYj5L
         LP8D2XtiOSl+OFeCXzU7NdOcz9Fb9r1fS8zP+xemI3I2d4JJufKZgZ/B/ozZk1dWe0dD
         ZxP2NJXXjv9aB/KGm3uPw3gmsRY+S4nwu34ca18qOE9B9erxnP1ClWOoNCszh5w/R7c3
         JYyu63nw3LW/Y2j25QgzRYPt4421GeKwkjV/DPb3Y0R2712LPafv0TrocjmyLWUYBrCh
         /XflqlYxR+8R/PPaZ29Z3JAx7OjurYmDdcvmFg6dJSa06z/F5BKLvPZej1UjyFtbKZyh
         5VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769063897; x=1769668697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQx7O5NghLYNBkSA5AvG3G9IxYGMgWQ49DFOfMxithw=;
        b=wfP4Ygln8X2PRu4A6pJ7GTG3ZSttwoFIapxvOOZdIlsArNs/0FuZlyzmjaLWT5iINO
         8a8+ICHhwUyLFmInfg+adofYe5oK1J2C0GwuU2ifDBiKbderbI3zVqn/zc1cbMaZNlvD
         enJP2vYb/uHdova1hF02vKSozVr3gJp95dJ/TAqwQnjTIXsju7qJWPtKKpUrHaKV7D9k
         yy6ghm7yIlUiswjbw1VS6lSHPUxFrsvZuTJl5IFblagjhfw0DJtU1l028NFJhdMJycRC
         6YCCCIzzmKfBcWuIBh1uXCHB69nTLhgSmBQU8MERZAntKjUJ8XHsR0dKlbEF/PPilnXD
         PeGg==
X-Gm-Message-State: AOJu0YyeD5HkMm6okQK0HeWVQzkSj3adoQFXBz+G14hL+tNmaj8/W2LU
	1zDAbqi1qeYK9xnYtZvNq5dCj+yWw61otOop9KBUtbWw6dy3RH/DKhYcdnxUaiypk/ga1yUEi4y
	57DSthVIRQt+cd6G3w/InMGvKnZBRWUnWG+0K8WzXzoNzXCcEHRz/oOzT/Fz5
X-Gm-Gg: AZuq6aI6t0gRfwSjddOAiKFei3jHGnHfq5IfKwOseg8rM6CygpOTQLWmSy5EW2Yy1yx
	usLHmYllyAXYkb8jycjykWPrMmybK7mzySV1C3G3INr7eTFOt1660n7RkiyT3VdqGYTgfmdhhhH
	r3rtwWLMPVxqm1vcqXGd1dT+hFWRW+XDgZyIOLdTu4MP96oidNVDi5GU3pJl/1w7DHSTKoLi7Xf
	MIcpKvp2N5IsxKp5xKKZsK4j3W4OsFCrevOwt66stZD1bwY5L/ZTKZeY4v02Q8x+y3wAY/+qCNL
	cZa/qon67ejTcaEfsEOLAisOXkCsbhnA0MKPauu00I4k4aR4PtY4lPHbdsGj9Ys4b49o5woQ4tg
	iEV0iGkrZd3PB7tSjmbrrcVX2JcN0vRUa0l1w7A6MRVYp
X-Received: by 2002:a05:600c:a013:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4803e7f0e39mr119642185e9.30.1769063897495;
        Wed, 21 Jan 2026 22:38:17 -0800 (PST)
X-Received: by 2002:a05:600c:a013:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4803e7f0e39mr119641945e9.30.1769063897053;
        Wed, 21 Jan 2026 22:38:17 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48048b49880sm29365415e9.11.2026.01.21.22.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 22:38:16 -0800 (PST)
Message-ID: <3ca5bec2-a138-4f3b-990a-8c786c1c247c@redhat.com>
Date: Thu, 22 Jan 2026 07:38:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] selftests/bpf: Running test_progs with distro configs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
 <CAADnVQ+hTZ_ynDJk+pccBwHGLs3hyvjDUGyiaKR2osmi0VAQ9g@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+hTZ_ynDJk+pccBwHGLs3hyvjDUGyiaKR2osmi0VAQ9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/21/26 21:54, Alexei Starovoitov wrote:
> On Wed, Jan 21, 2026 at 7:02 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> Hi,
>>
>> I know this has been discussed multiple times already but I'd still like
>> to open the topic again.
>>
>> We struggle to run BPF selftests, especially test_progs, on distros
>> whose configuration is different from what is in
>> tools/testings/selftests/bpf/config. While the tests usually compile
>> fine, many test cases fail because some required config option is not
>> set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepable
>> tracing programs, which is often not enabled on enterprise systems).
>> This makes processing the tests output much harder.
>>
>> One possible solution would be to maintain our own DENYLIST but I can
>> imagine that the same problem affects other distro folks. So, I'm
>> wondering if the community would be interested in some solution which
>> could live inside the upstream repo. Obviously, I don't want any
>> complicated solution which would require a lot of maintenance and would
>> bit-rot over time. So, I'm thinking something like introducing
>> CONFIG_DENYLIST which would contain "config:testcase" pairs and a couple
>> of lines of code to test_progs runner which would parse the file and
>> automatically skip the given test cases if the required config is not
>> enabled.
> 
> test_progs already has -a and -b and BPF CI is using it to
> silence the flaky tests on some archs beyond what's in selftests/bpf/DENYLIST*
> already.
> For your use case I think you can introduce DENYLIST.redhat file.

A separate DENYLIST file is a good idea. I just wanted to check if folks
want to share these per-config rather than per-distro. In case this is
only suitable for RHEL, then we'll certainly go with a separate DENYLIST.

