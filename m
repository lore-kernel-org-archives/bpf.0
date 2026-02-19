Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F82C0294
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528518; cv=none; b=UI2J8OY06cjATTXidLGUBHEPG+xPumzZHiA3hfxGSBL0f9glDDEmIbw9X5bviVS7PhcUjodbfuVcGbcpejlpNr0MbtaS68w/MkqxNjKkgW2Ixxn8jEimCeDV/W6M/rS503FHNeG/l8/ICXzhydYSMaXGdqZqVkuDYnTEUaYLsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528518; c=relaxed/simple;
	bh=0gkmir7Dg84DIj2NqS7pC8gGD0qGSz0cFFvUXtQdQMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5O1U0CCpKh7myft0xKztoTEeQB35St+XsFVAVR2VqxBzYudBCXVIY8Mt+80xbBdPubnUvm9qwmS85bTFvIk2QfiMVE3D3F5WhsOOXA9y1G3JiHBI/UCLy89D2i2EOv39495Db2qFgKy2reuNeK7SIAJGNBUPEK9bbSUddoC//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL+zcT/h; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL+zcT/h"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2baab3137bcso1171692eec.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771528516; x=1772133316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKXPKRIMQX0M/LU7nK6tMFNe40zI+JHq9z0mH/36x9E=;
        b=WL+zcT/hlNDs7HDTTsYFfGTB8g/0kik6EvUdgHmLCaYcbUnr3QBYqUo3dGf4GDYE11
         m74cl//wYTy0mujBgrv8iN/t7eXz12N2ZM+Yvf/xnsZ+gaIgrQsK+M1EZpCeSQpTiAfG
         S8S8Qw9IaRPMM0zymw5y/VWxmuKF+LSYMl3jFVLMYPbZ+Ox9fVkLsTX+fAV4fdIJ/OuP
         HduJIk/6eDlr5XkmQYDlfwLNPF5P9BPHJhhcG93ndtOXi6+UXRnZVVS5u6Lm6TadiI4/
         21qBeQ4XR2pKjHnLiS2+4S6dcOCFg7oPCdcurZX6qJTMt9HQPKyrKnDlZozj7gPEwMSa
         VKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771528516; x=1772133316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKXPKRIMQX0M/LU7nK6tMFNe40zI+JHq9z0mH/36x9E=;
        b=w57NuAOyQzC5oHCAyy704sQZuTTzVMahTTlquWpNWz6MR2bP1Gd61eqfSZtQ02dt88
         K+GLQt5+VjMy9uhhk160SB1P1Q5fB/rodED0c+wwBG5NQMbOO5dYDjcsl3DO11qKuYhz
         JKfpu2HDpR61dkacFVPxHv4bIVZYVQ9ezshLnwRh4zeVydehw/EdYsRmqhv21tsqFxDF
         mAtvXlRwDML8mtdplcmyZcb7sR+zQUtrJRdYN4WHlXQSldM+808NFJ4a9T8idx3AQUnE
         VvUqA4keC7ClV16XnCowFU6bCpOGF80hAoS745pq4Vyv4lanX+fHfsYTn8iukRHPRDpv
         50Hw==
X-Gm-Message-State: AOJu0YwK8dbjzyS/JQjWbFNRU/SwttQF4O1QId9m9ViHtOjWrSIZJMt6
	bv8Qn0gQ47EQy2a5Sivn/XYX90p6f1Rlx2Su0h6R7Mr4pJixOIj0Qys=
X-Gm-Gg: AZuq6aK6kyi2iAmYpTrb57pbhBpwYj895IyQe62OP1LbHVVfOQ2um5Lhd/+17Qioowf
	t9CXw4Q87JbdoOxM+8kPptAOzkbwwTtUl85HjEGu1sIiAwkbfJV+hDOBZNADgwTEEL9/ZX5LjJQ
	1OWqH6Fyh5v9gVmUuBPSWL9XmVzH615VC7u8tZc5kANPMEQlvbJEgbfUV7s9dF0yKX4BnGDAQGv
	YGBEF44SI9LCaayL8PqBctxIGtq0boWRV2Z/ajMDJz5I9hR2uXCptJNvDzUvvhEW8AZt8f0My7a
	KWzGM1c4tTEPImZc+jaVnQ5/maIKHAl/YA5YCZWnPTlDPvYKnOzw35eibOedYLgS2ICD/cX/Rox
	EPFeKYJ+N3L/OedbVi5gsZ92kcrLOW86Uq+1cbsh3ckG0EYdfcVVkRZ/INPh3iDtQq6viNGO9bY
	ct3aaW7WOO+vHy7ll8KNfDfC9tA9kbnBfMfddO8sqfbmrogynoZL+S78x0DJKXJHyGx7Bez7OD1
	8dW1iFwSRoYqZ7klw==
X-Received: by 2002:a05:7301:d1a:b0:2ba:8f0d:cfe with SMTP id 5a478bee46e88-2bac933a6femr9943515eec.9.1771528515983;
        Thu, 19 Feb 2026 11:15:15 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm25299392eec.22.2026.02.19.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:15:15 -0800 (PST)
Date: Thu, 19 Feb 2026 11:15:14 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com
Subject: Re: [PATCH bpf-next] xsk: avoid double checking against rx queue
 being full
Message-ID: <aZdhQv_VEc5VgsSU@mini-arch>
References: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218150000.301176-1-maciej.fijalkowski@intel.com>

On 02/18, Maciej Fijalkowski wrote:
> Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
> rx queue has enough space for producing descriptors:
> 1.
> 	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> 		xs->rx_queue_full++;
> 		return -ENOBUFS;
> 	}
> 2.
> 	__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
> 	-> err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
> 	  -> if (xskq_prod_is_full(q))
> 
> Second part is redundant as in 1. we already peeked onto rx queue and
> checked that there is enough space to produce given amount of
> descriptors.
> 
> Provide helper functions that will skip it and therefore optimize code.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
