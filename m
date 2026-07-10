Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BF50276
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642425; cv=none; b=ixu0IklDRcA5Lu9se1hzjcvQq7+2FX5CU8g6F9r86rJn4W4KS4YNBNM+OjtrtOYSykeHlmD7KrIQFsUCZ5zrBC0muRBGP88KGilbjasWrw9ZnAsUP9r9jqoYdjn0WNTRxLUBOB8mcapY1LJPWZI7EFLX2UfcFNnFP6NfYWnjdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642425; c=relaxed/simple;
	bh=j6cD37JPU3LgqmeqiWNo7VSeZ5CTob89eIMYZjloUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f++Z+xF4yVZfShAeBWDI9KrNNCSGKogCUmwlCbyuA0D+nQnScvkY5QCSXLFMUtBfNwG6EWi3Nxbt5td2mIV0QSNN12CaFiFO5U8jjhs/II69B/co7/ohyH52eJI5TtO+Hx5ZF7LqtIWYyr35tr26eGHlOsCfQZQ1N8gz0k9B6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNC8h7iC; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNC8h7iC"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so120139a12.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642424; x=1784247224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWbkBRfCnrkzUaFcgrHq6MP6NIH7xy8BwEhQEhBxfHw=;
        b=lNC8h7iC24zMPg3MEoptz+cTiPliKE4B5S2WVhbn6DadtHPrk+IV2APD6qjHM7sSrR
         5hySUUiAJSnZR2bqpUUg6TOXCBZPWDJHBPCIXlJmF+wHa6DoBzQBEH2mwtFTQBu3vgW0
         ITKGSIhN0W3j1XEBAhWkV4LV+sX4NZqFldV3ftImLSkw46F+26wAfoPkzaur1g8kutya
         vGAYNUgh7ocls8qBTONfbCorCvQAcEYGPjKSW82kKj/lUmFFYYACjJeLBsJRI+O1xLr6
         mNW3HH665Z56CLJFbqgecMlYQs12aZGE31YOYT4X998AbnNj0DGHj92PXNdhxwMxHZAb
         zNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642424; x=1784247224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWbkBRfCnrkzUaFcgrHq6MP6NIH7xy8BwEhQEhBxfHw=;
        b=XytbXQ0586B1tx03ap2qKvLOzGAyXMkvBLtWYProAQge90FVOz+0nwQQx5g9raMHwK
         0aRBk9xDkEuFZnitNZJ2dTVFLzihTnZJT+EZX2C+GWWzQhKlGJyj9jB5mO6eoSZvqRL2
         r6J8tvPK3Ggrgsth1PWurdfMt7lrXXm6Z9/PjBY7gRGjYmw7X72KFCJYJTZty9hXDXXn
         OjsS4PawO7S8FvfW3CTayJDl9/foMt+5F1vlnuR8eCGlo4JI6CS1MSYQHPfslp3V23aw
         dbYMw+Is3kjiy6sUFgp5uLuVJhABXHv5xL/zH6qVK4OwlmACeOCxPHT9oxPomak5gYJu
         245g==
X-Gm-Message-State: AOJu0YzT8VdRj0fymqLLceK50FTWN1BPS1qcdyGWtM2hCdz+lsEThgyc
	XwI5Lrjn/9EsMB+cNMQWc1a2DH5W4F88LvFlXEbJ4AbHaVfu7A0JFLvF
X-Gm-Gg: AfdE7ckPeSFDTCIvucEWZp5ie4itURu5Kni01jf6n78u5+7OLFGUL6S6rE2qs1wT7S4
	zwXXbvNyJGH2zKFMUKwBVNcPdWJDVkAaw6+/lOS0WOOiMpUGAWBDWrUCR0shKCyAJ8ayApDjKaa
	wdD6FSDAG92Q+98QPe72s5QnQO7g8MqxIRL2Cgu1l/PUTwJbuLvrc4tXOLWXn0drL2CbDs2vphs
	pQaC1+cnMk/aQFSFKfAzIM+OywhG61+DIil93+Q0jwOAbCXIbbo5P2vYsyCPlwzXuls63nqOJ7G
	wn63Wbdqz78FFagEVcvEIQmyDy2i+O4m9ctcZjGscA+3MOuMCAebu06tCz8pts3kjRuBrC1XHox
	drbm4xeAFPujoDrk8lguN/Le9X1RrOkGT0jZK+k4Uqzav6cL9EEt+j7Bf40+zP2JCZReZTAEiCh
	5DF5DwEI2YEdViL4ZG
X-Received: by 2002:a05:6a00:298e:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84842d4ea41mr8051586b3a.0.1783642423638;
        Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84831643b9csm4834109b3a.6.2026.07.09.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:13:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no
 route test
Message-ID: <alA5GARDnZkg8RT1@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-6-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-6-mahe.tardy@gmail.com>

On 07/09, Mahe Tardy wrote:
> For normal live cgroup_skb paths, the skb should already be routed. The
> exception is for test run via BPF_PROG_TEST_RUN with packets created
> via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
> would quietly fail by returning early.
> 
> This test exercises this and makes sure the kfunc returns -ENETUNREACH.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
