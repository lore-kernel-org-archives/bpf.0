Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFF45C1C
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523569; cv=none; b=GUd8VdWJ1//4hkGylD2LDFOMr7bHz2TSYzV3Cq6RR7I0mcD8dUG8IxjzsvdevkdA6xf/7NVrmcLUw8OjA7nXBtA0uUvyyTo6jz6fu0RVNzlwqr1AsuiahOczYPjBcKuWK9t1aURPwxyYfbp1PRbPzQTD9uUN3Ttuq8GbCSpzHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523569; c=relaxed/simple;
	bh=cFTdYcax5gRdWhzgeNIJ1mjhAy6vbDir1d7YavE2RGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNFok1D1RdJcRfa6orUdLcoesDRDcxxMomaJFQ+IBAhTJZXxYuvuXFw1YJwu+GqP9ffzSzeRCmhC4IF/ag7BdTrnoMKt0iZufkhZdrf1uBTKT+JIEbItq8KMeKDpUiJUypA5JIh1G3tX1x7p9iKB+8Ipj6AGzKFM4gr9vICEfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYf/YMrU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYf/YMrU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dda27c98ddso20318635ad.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710523566; x=1711128366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvVwcEiJwAJ+sbhcH9TeiA0j2HoTmMi1pHT6QVcoQQY=;
        b=BYf/YMrUfmPrwO+TKfdeVk8e9+2FR2CJj3IHxzYPbWxrAXn4sX3YoXLBKxFNAhvaTH
         V6zPOsxtAzKai77boYNETzcnP3A1LNirQZPXTuSeOmods7mv8LBNZvi1ErNq91JghmgD
         2LbZP9WBh1t1M5XNyuRV0D8bL7IlpuHQCxvIExvO5U1h1tZEKOyLk9ez6tGZJFIM4n6h
         klQysXxlgRn8IyrcncF7DHzvP9jW7OrtsLmowHa1b0XvGtzmvi0+4H3A5t6IX/Js3eOy
         mOfpxKjOH8ZU9d5XQKHSBTc7R3Nb6bDZq3Ru7Ro7zv5N8LwvzR00fkeWtjOs1jFaaO7j
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523566; x=1711128366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvVwcEiJwAJ+sbhcH9TeiA0j2HoTmMi1pHT6QVcoQQY=;
        b=pBYIZ72zcwV9oTwHbtWfS7WvXot9CgWzxs/EG26dbC9dSkphwkB1mwmgV5C6UDRSZx
         JTbqpM8nWU9i9cCiQacZ+aaB7wIBP2V2xfib1hIqa6Q8f8r18y+jlfLAHlTA4Xy8f6M0
         NpSTrGyD5ZrDdC9HslXuWQeF802C2TgzJ0M89Jkwr0SCLMS9P/k8ju8CUPMdTNUUtOgG
         Z2QxTr4h96OV0/4z9Twlf451gWLxnhK6OnT2r6wRkT3LZQ/XKIRNmm4sdyN7AKrJjfsL
         xfCUAEnUQJoAgZmj+JMmvBrUcoxxAf82WZL1aVNxRjXEhWO7FVUjoDq8KN378xiGM8qB
         gtqg==
X-Forwarded-Encrypted: i=1; AJvYcCWKdGlrYDTtw4BqY0oZEFjNV1wKS6CyjqhZc2jlXUK3AlfnlmEcnX0IdQ7uoF+oZBSXCq/QNIvPB/9YHXFlzJBHjug+
X-Gm-Message-State: AOJu0Yz3tBr8LVUn/DpXxgaKsStPZ4IitFP7qIT5eihy5o/clnShH7iT
	jfrsRLhKnJzKnzeu6dAopLb/Y+gr05GRstvcllIeB2dyuwj72scdK2LZks5ARaIDxA==
X-Google-Smtp-Source: AGHT+IG7rbyBC8cmSfSgM1ZPt/64xcQzRHRYJmtaC9Fz4S0LeyUtL6P76VYLMAsrIGzOhoP6Sg/8mug=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e5c7:b0:1dd:dbf6:57de with SMTP id
 u7-20020a170902e5c700b001dddbf657demr46533plf.12.1710523566056; Fri, 15 Mar
 2024 10:26:06 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:26:04 -0700
In-Reply-To: <20240315012249.439639-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZfNXjd1ML2WJwOKX@google.com> <20240315012249.439639-1-liucong2@kylinos.cn>
Message-ID: <ZfSErGdSKDnMpPzd@google.com>
Subject: Re: [PATCH v2] tools/Makefile: Remove cgroup target
From: Stanislav Fomichev <sdf@google.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, 
	ddrokosov@salutedevices.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/15, Cong Liu wrote:
> The tools/cgroup directory no longer contains a Makefile.  This patch
> updates the top-level tools/Makefile to remove references to building
> and installing cgroup components. This change reflects the current
> structure of the tools directory and fixes the build failure when
> building tools in the top-level directory.
> 
> linux/tools$ make cgroup
>   DESCEND cgroup
> make[1]: *** No targets specified and no makefile found.  Stop.
> make: *** [Makefile:73: cgroup] Error 2
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>
