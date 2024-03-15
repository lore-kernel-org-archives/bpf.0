Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E017984
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534778; cv=none; b=pn5pwpCZDml/gyc4DV4dnacaFtRwv2BpBplazLgq9IUTwnOwmyhq2ym97QOokSCJhkFACYfO+6XPTMYTz0iw0pXp86uenYQz+vnMQabozxVc4XwESE0JYdP/g/FmWrssFApl8+6lJp+V1N7vO/8JxixcnaXsMXuNYVegePEa/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534778; c=relaxed/simple;
	bh=1mU/56UpqgsMNF4iqplujoy6xyARccZ074+3IQgH9sU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U8BiRUbKaRtbQg//wNiTNFPUbaFKao9wJecBhy+3bxg/P3cfpto0au6EFKxWtwXyVwQKb1o0ZQxyZm8QzYf76YGzjjUMn7mKfAeRM1i5hU1YtK2AZwuRoXCv7PjrdP7bhEuq7ULq1PrffqZPZ/PBXORtTsjHzSk/xK2JswM0mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1i/C2MrX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1i/C2MrX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2b82039bso43683337b3.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710534776; x=1711139576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0NqbUpBLkZIrJeU9aCDr6wtzsg7fBWA3oqQjyLe2jg=;
        b=1i/C2MrXHXdvlDZWg5XY5rGPh0o9QDJbvCK7BjGHU+MjvhOtZuKuQO7i+igcu8HJr5
         yALmgrD1tWxBBWb5D93qoZXTV2wU3mOAYXFTnlQ6YZsuAL4/Pkvo0PM7Jmy5DxGxZJot
         sGjjJE/iD0OTNNCrz+lXyKp+0IiaHGuEWuvla7VkfoaZOzh04ilItAaGErCtf5vLaUTa
         XUxsUwb9h5cKdA+LUdHj2B/OdOor3LSgFVDsyc8bJYU72C0gGYEj5xCrHE1XdaQCCWut
         HquoB2z66/kCbieuDPnubSzgr5Kxbaus+weJ1Y70uwEGiy3fKiD/z/pKTFrpksFoy9Os
         bKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710534776; x=1711139576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0NqbUpBLkZIrJeU9aCDr6wtzsg7fBWA3oqQjyLe2jg=;
        b=YsZqrREcalC/WWc6zbRX0bq6K8/1GMQoGWhsojJ2Xzm73r5T8WgHGe/O2BYoQyICJF
         wFSKp7ADF1WxvGyPd8s8rjWpplx1E4PIcWi9gy+BnnWn67wvfLHbxZv+sVG4GTe6TTF6
         QWCA/JEEin2G41rk3RX/ANOH7KichU2y5m5/IAr1ifGzfMHlt1sF1KF1r3OrkUttnqsm
         W+1941jIdlFk2xcW+zpm8+/tFw10gUM4UP0BYxKoSpjAh2hh742xpgwSM1wiWuar6Kk/
         wwE3cZ0rLasSlExrbVOpUPM9JyUOw923/djT+YrNkegjomUCL1x8BYgpakVU4cjnxOo5
         PcoQ==
X-Gm-Message-State: AOJu0YyBds/WP6Ipf+/F+I26jJ8it2dWwS3mYzlRDlnwJ9JkFo3RebXG
	+dMEMxVVrRU4LbMy+1mDiOo8zkWSuuwasDoMkVZXfGY6t2fn42YF3o307TG1ZRs5pg==
X-Google-Smtp-Source: AGHT+IEZEd90nnpS4hU68iaoK1mB6d2+CQqyIuftLpUCNT15Gjd2ObNXSReOIAoqdK4o2Hzcayxf63Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:db08:0:b0:608:d499:3439 with SMTP id
 d8-20020a0ddb08000000b00608d4993439mr890791ywe.7.1710534776143; Fri, 15 Mar
 2024 13:32:56 -0700 (PDT)
Date: Fri, 15 Mar 2024 13:32:54 -0700
In-Reply-To: <20240315192112.2825039-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315192112.2825039-1-martin.lau@linux.dev>
Message-ID: <ZfSwdgGcQypDLVXh@google.com>
Subject: Re: [PATCH bpf-next] bpf: Remove unnecessary err < 0 check in bpf_struct_ops_map_update_elem
From: Stanislav Fomichev <sdf@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="utf-8"

On 03/15, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> There is a "if (err)" check earlier, so the "if (err < 0)"
> check that this patch removing is unnecessary. It was my overlook
> when making adjustments to the bpf_struct_ops_prepare_trampoline()
> such that the caller does not have to worry about the new page when
> the function returns error.
> 
> Cc: Kui-Feng Lee <thinker.li@gmail.com>
> Fixes: 187e2af05abe ("bpf: struct_ops supports more than one page for trampolines.")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>
