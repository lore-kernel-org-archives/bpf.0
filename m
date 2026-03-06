Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED236D4FA
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774284; cv=none; b=MTxBw89ZqN/rXNyY3FCJ6j/6rEInlv3niMSi0Cvh5BlP8oI5QgOZR5OUvChAl5LIhYuG/UQAPFITTO4hTDO66i+jJBhQkPx/AffkdXQmVr0pRj9KM43iwtLuIDck5lLYtIWUhP05T8qOAHJdq0wgoWr+Ufbn9p47P1TYaiGzIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774284; c=relaxed/simple;
	bh=on1Qkb4/RzoXx3b8AOjJIK8cGF7ipXEdpeHhB3e7bjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tizwpcUrqyNiCOUZAvV/fLvafphZX+bTWDUrb4MCNw+Cew1P5MIXZGDQpLwrkg6nJAqsEqGWLDlUGqjZY9ZI9A78P22BljvkGTrB009nbORmy5hbUoJZwEhX82kD44+9N8ODfYCg/u81kNNjRdKrWS+IcCImhquYjXburiLzu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GskxK25P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GskxK25P"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3259429f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 21:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772774280; x=1773379080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa/utmtpkkddihbWQ7xCVwU5KKj90Lo/Fkfn7w7Y8qI=;
        b=GskxK25P9au3JYcH4Ryrh1Yt8HOzhek/JrbtHGSsS3mPMdee/RtZh5PmRAvX2mJLPL
         Xp3SWk+62A+IJIzMxJJgk7wQPVoADSAUVStT6vIFGftgXkVJP0Z+f4CsCxB37qYQJhZi
         nYrTjj4Lob+cBXK5NRfuzM48LGHdYoCPCME7p81zjWgxrIHKJTucnJ06SixkB0hO5gYj
         dGyhqNNiO3zSw93+OfolrIqmYQdeyCknMyDtHdmvCvKLLbKpviG+g2aXzIFmj10PkFQi
         S0TGXxQvtmZzHlhrKSZyeYPSBrJxjAhT+Hov4l1AXpJdiVkJMgQSFyn1UhGqt1mpPVcR
         j5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772774280; x=1773379080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa/utmtpkkddihbWQ7xCVwU5KKj90Lo/Fkfn7w7Y8qI=;
        b=W7DyDqWmI3pVF3shndYFRyA96W7fWDKr9scCGQOj06ipz5xRoHA5LkHZRsvdki/PWh
         BPhEDaYiS3gkWraqQ5u8010jNaxHrRPIIbdyMB+TSu/UqOUe9XJSfj4eUGhvRtlupETi
         IePq9lbZhjrv/TyA/t+eSQblVI33Gt1Y5fa3VXUEWZszJ2dWwzjMx3WjsBmbbYzbYlIg
         dEoCSaedH7XoZRUBYeqTpOjA5bMFZaTTbQ1rZw5wernF/XvQbDf4W5MHbDNc4aSC6MGB
         UzNbKGaI/nmq8APWUMczKC+FsRe6NcSd5bA4Knl0M1n8eRyWKw7iv7Hc/zBxalJ/1SHg
         j/yg==
X-Gm-Message-State: AOJu0YyY4qWWhbok7kzF4Gu1XjqWwsla4twhEkQFteluiXQFk7ziQclM
	OVnmCh7FRlDDv0CIEvOXAP5Ui4kMQgNj/Du0CospEImFV0vMgehfhPCMEfFCIVoyNcg=
X-Gm-Gg: ATEYQzzMys8DPjBb1Yy2bJft9mjiIs32JD3BAxe3z/vJf6e6j26icCoO8udhMcQbYpt
	+c7M/kOChtzxdDB6mHsHirsSitsF550iHzv41gTO9LJXeSNP5WA7m8Z9uJHQtWinYqdo/O3Ahbs
	JCFCcfSZp8v7T+a7eX00sSAhYhZ55/AmP2JaTwVhnyd+E5GIClIqJOEMP5jqJRgaDyNc4F53niE
	f6vHvpTsCUhkNhkv8sKbkAU25ZZfjEBroViH2ZV4D7fnyhAFfOfPYH0ksVu5HLlQs8iQ9vHd/Xi
	lcuuR6P80yB2wzF/lYlVeGk8aps2KRWCWZqUy1B3YOPnjmRl6UwZEi54mcx/uHPi3X882E3q7wt
	49sdq/Prew2GQ7bYEESSqcKWvKnxsKgQnuM8S0UiNKdF5Bq9/6hF40sjufIfd3uGSzWhiBEG/N5
	m2NvaNKGxfaiObr7OSads=
X-Received: by 2002:a05:600c:8586:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-4851ee73b5dmr78728615e9.5.1772774279864;
        Thu, 05 Mar 2026 21:17:59 -0800 (PST)
Received: from u94a ([2401:e180:8d04:ef14:c2ab:34a8:92f4:47b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57740sm4838825ad.15.2026.03.05.21.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 21:17:58 -0800 (PST)
Date: Fri, 6 Mar 2026 13:17:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com
Subject: Re: [PATCH bpf v2 0/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <zr5324tfnwrgnui7m4aub3kvpna5hcwsu6uorzx7awzdjhil53@hyf2fkn63532>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>

On Thu, Mar 05, 2026 at 11:48:21AM -0800, Eduard Zingerman wrote:
> Cover the following cases in range refinement logic for 32-bit ranges:
> - s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
>   overlaps with u32 range.
> - s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
>   overlaps with u32 range.
> 
> These cases are already handled for 64-bit range refinement.

LGTM.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
