Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B23A6F1C
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413443; cv=none; b=uXfIoj3FPzEEkD+NOPc9St16jmx8RhuO+Zi8U3EuTwSgx3RzQTrb/KJEqNqbNiFAd8E30h0TrhCSY/it+Z1bVHMotyTnLn+0/XUa3S/eNmm6lyDrek8q6bT+Pz2ZcC7XsvhCJXCZjU2VqsEbd5MxCltC+px7ZJXNdl54CZSqB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413443; c=relaxed/simple;
	bh=jTpNmNzq5hb9oySY4Wy9mvNAKspFAqshWPXkSwe0BYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqYL+Ro0QNMNQS5w5q8T+TXSOAJqBOfw7+fIfB9oGDVfIViL6U/5oR+0Q+k5yGGULG+L6BehdJnVsHfhY//pbfB1I6raHZRU+AKEv87+Cg9eTpTc4ccx1pNXd59Aj8Y6dKlmRo6HyNzJZI81kFMkRTw01CHNdQJ/OKgDhRiiwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO2A4zvJ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO2A4zvJ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be4781d2baso6271040eec.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773413441; x=1774018241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AMQmdUQA1m4tr/S/j/CmgmciqopOGOeSDwB5uJ/htY=;
        b=BO2A4zvJMnga7p1LULepnyLlAn0RdzrgE00Fjfgc72GbNvjfM9jWO21PTtLOFdVTWS
         t+zHP8+CSyVDSc9nkMdszMNkidPwICAoVLXdqyYnBDREiKLvUtWsCgQw9oroAf2KWiZm
         OTvDrNK8YZxmRrNai1Ejh5eOccm2JBgx7tIzHm9uAdwT+jFzlrN1xBof1Q/VblFNTEwf
         /pW3ITx/VZR6lx3VKfICk3ZEWIurHLwL3trhNsStV5aL5N5IlAe7nDoVqQtNTkc+lv8s
         VqnL1rj10/2s5Jz9/2tJ0s8nRs4KofOdFoN5i5IgXSVfIIS33sJhHnQRajzU2+lEvko7
         n2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413441; x=1774018241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AMQmdUQA1m4tr/S/j/CmgmciqopOGOeSDwB5uJ/htY=;
        b=bsanZnWdsTiAfoJLk2gp7DH3qwtZHkWNjBqWo9ge8zpItg8KyteiMTX6JDRrcKUX+6
         Ccl9mwflQlylOq1FAJGKIK4eCrQI1VTgTEzzSnSpVfEEYV1sn9N4xgi03P01eD0tTS1Y
         UZxTXPwaKccJbqqhCMQaQzg0sSAeEsUVDoWlFaSfgJNmgW5npMapACSx/TgM8V2IuBe9
         qRonXRm2oFWa+XTokaxA11Vn/JFfaXIKHJbSIJztHBnsx2ULHGycCZlSxETiIMUl4NUX
         YDruMIomfmMH6pfjg6N5ZZVvlA2x9GKyt5XMNGqaZZaiKRJSH34JYVaeYbaJ3NJ199jf
         Oo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKSRoqXjN+5jFMfJdJpMy6f/YO6rGTDjTqMEgjpIWNDWdCdj3yjX2DwMS8NGP3nZDSbg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+z4A5vGX7Us5CsEGwO+0Y+5N3bmWdO0VKMDXnF241JM7lEcs
	IKo9lfMEptDrZ8qCGtaBUHt5qth1ztcZQ+7ASmvZOtMiPzdEww9jyGg=
X-Gm-Gg: ATEYQzxPzvyo3lfStSOrrVKK0US2Q9a7nFrS27dd9rojz/nkhX/q8Ezd4lDt/vNh9Oi
	zEO1XR4XvHx0SVag6wgVB+gAKN/0nWh+9d2hJ8iXaSGJxzCAzYzt9f+oovCPtQUigf5QjfCeYr9
	ioRjFURKt/jMNzhPYiU1wlbRD9HaGpPW/7vftOMVn6QWZOndZGBtBXpKthWhLM/5Q+RpG8rAFrY
	ad8vCG50WQoulyV4nTirN6Yu8kjsDsoMRmnEb+31IUW5SDo6xDgz7E3ut6Ua6l33IOJl8jOnDeD
	iTNIrQXyXm+Tq5vk841uZPv7ljM+1FOytVBOtt1CRa219kGp6EiP/1qPlXHv4kwGYEvBBVnYe1Y
	DPrRO/WN/w8aiO1iqkOrQ4ydfPfIuslS72BUI/yiQzV97p1aYeyLFKxO6O9cA7/0Jnc2r3mMdzV
	sw9cOTPFxtq5/WWwZp21nm5URHTahRWN9lItFWcZOkS+8KEkFGZmqxCz7l2Ip9rj3E/qjbK4rxn
	a9mKkWtprZ9SWiXclW0twnefKnw
X-Received: by 2002:a05:7300:1893:b0:2bd:f280:58d4 with SMTP id 5a478bee46e88-2bea541a70cmr1860057eec.6.1773413440904;
        Fri, 13 Mar 2026 07:50:40 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1117sm3382462eec.3.2026.03.13.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:50:40 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:50:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2 net-next] xsk: remove repeated defines
Message-ID: <abQkPzFIjAowYsrF@mini-arch>
References: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313111931.438911-1-maciej.fijalkowski@intel.com>

On 03/13, Maciej Fijalkowski wrote:
> Seems we have been carrying around repeated defines for unaligned mode
> logic. Remove redundant ones.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: remove another repeated define (Stan, Paolo)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
