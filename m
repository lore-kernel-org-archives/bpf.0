Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F24BC00B
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674029; cv=none; b=L+QVeXavsOVaszrzwDplZ5HhEHsJztX2V9onM50Ti3hJj/8nKrdOdN85/Yjo4qba/MtcPD4+XKMRNGLps34XT62Ff9jpQcpsbrOqKh9/outvFr0laLdcKvNqk1YbqfavrUq9R04EUnmMK3abLq6e1n8T2jEKn/FBCWPCV0Bmhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674029; c=relaxed/simple;
	bh=fcXyvBXj7Sy0LffIiP8HJUW08OGSCuJRW/UUi7/DyfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8LlGJ3r0Bvl7h7gJ0yMBU73SzyXoJbzM+VT9gTyKI41QkPKPackQcLBSIB2Dgi28/JmSnLD5QDSM1usYr+c15d6jnxqjqztnbR7h0U4/rpKHGYXH1fSm7wmbOzGTTigXrfGTfe6l0gz0NWI50pD3rHfXetCQ0r/z8Jnb07HovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGvaV2Zz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPOGSHcb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGvaV2Zz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPOGSHcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790674019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
	b=EGvaV2ZzRI/OndavcLYpDBlajKS8C8K5Wx/1oqj97329cZi0rpb7lKSxnztIZR8NLB6Y7s
	8xWOwP0cMJ8FZP7OyJxqYbRqJDgQghSqWOmLYLsOtrD2brkNB5qsbqDF9aEcxmwp0LMbrG
	AL7OEQJZ4pL2XrnEOsze7S1KN2XgsOA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-VY59_rvRPlqkWCctdnxfkA-1; Tue, 29 Sep 2026 05:26:57 -0400
X-MC-Unique: VY59_rvRPlqkWCctdnxfkA-1
X-Mimecast-MFC-AGG-ID: VY59_rvRPlqkWCctdnxfkA_1790674017
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c294c2dcdf5so353093466b.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790674017; x=1791278817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
        b=DPOGSHcb/Cx2xsTfN3rRl/XFXi/pUVEaKMJ0u1vulQRjLMLed5jQ/z7Sy8/QYR7Q9y
         benk0CvkDOJkfxbrd0/PRRPTpOxWh+QqJmmI0k2kXRU7Kh7HGNXntNlM2bUlMfa6FKST
         l5OV14xUFwta0WAFG7jY7GJokTSjPt+k6am30s+fFXLri80Q87GpIZP6/C5J/LEiAIrX
         JBSyMT74RjZOf6vhMVMVzF5GfOHdxsfe1XeKfe7lqy0T97TbvG/kHZ07gaOSOt+8cG7W
         LkZrBXQYIC4X804i8gjE12hKtJ0+Ps5PzKMLzxm8uyrITRKqiw7JyEkJGVYJRJtOJhIQ
         Kj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674017; x=1791278817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sekRSkYgEhXbsBdIcUfoQ0jf7hqjPYSNiBc5T17KCjY=;
        b=HFwHaV/3+IcG2qPzpbBCNQQ2D+C+Ek21qiycZv4zRR0ybLUHfMDWmMyaVBQxLJ9sxg
         nvWnRfJ4cS8jnEz+a3zAPKuKB+weRV38PBAoGEm1BhbZHzbFu/Cugu+SPn9ZdJzSmt0g
         H/dKXNS1OW+/GXeBpSqQYdnLgo3KQyKct0pjsnQ11bLIIXVRYuwEVwT4iUY/lkuVD/+W
         OofnHUvoiD0FyQ9OzxqEsDyu5Q8vC0WIKjoL6nXG4dl31SFESlYeGTneB2PjtcCTlOcv
         D15nxTrwhlsEAPIBWPgMkwX1cys8JPRhtbB5QU7v0ghWpNVJua9F6NdGGqcwHFi08Wlw
         Ch5w==
X-Forwarded-Encrypted: i=1; AKwUvBzJ3BGmy6Y3mkG8lSo3Rf4C5AyB0NGrT5e5O61jq0QUh2VLSqGyvldlYPPMbdHT4bLiQW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXNOjOn/PCdYTeBiK1Ar2DLUxNPaik8uKAazJ8IOdXb3hdMFUe
	YkMjeIWmxicLHIa2P25X9B9nkvXKIzP9PubYKQcnLPcy6BpkPbDswS38/xil41fUjaxf/SlnA0y
	fxJes3n/kpvIRehs7b8hdYD9N2EiFLLOdeR5qaHfJLQHx1IYsRsVbYw==
X-Gm-Gg: AYBFou2IHpJ7YxdH3QlGJh/e7VhS8MD7hCa7ylfZ0zq2CXTZ0oGmDHvw7F3rm4fmR72
	RhbKLLEQHvEJCoztzGwTAieiBfl7SHCUL4dXUkcmmgRtMiv41unZSbvOL4FZPj3XxbPujz6D2Uq
	NrI+dozWSG7x/0rLCt4MSfKYQE2lx6KnyBGd9KIpKpkJfkDwMvQMV4Q72q32UfE+tmWuu1IPMlW
	dLtlFucn5lkhlE7TUtdU9SSGsj5S4CcrCWXRDoV18TV/++dovnDdxAT0m7NVig7Ji775ykMoDu7
	4s+fIZEDr0x3F0O0lX6lSvmLokeoy/F8fmmkR/2ARHxvfUJIsO5J3DlWY0k/HYcF8LGOWn446tg
	WcT7OKd109ZHr4Sw4RTf1aNW0OHpWyGS5Y9cB8xuRZuzfNrQQC+u1HQAJxuWqHJUA/vSBtuM6Zw
	==
X-Received: by 2002:a17:906:730d:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c2ac23bf51fmr1255285166b.17.1790674016574;
        Tue, 29 Sep 2026 02:26:56 -0700 (PDT)
X-Received: by 2002:a17:906:730d:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c2ac23bf51fmr1255281466b.17.1790674016087;
        Tue, 29 Sep 2026 02:26:56 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678bbb0sm601169966b.5.2026.09.29.02.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 02:26:55 -0700 (PDT)
Message-ID: <286547c9-9f4a-4202-a615-b51d42850951@redhat.com>
Date: Tue, 29 Sep 2026 11:26:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/12] gve: simplify reset logic
To: netdev-bot+sashiko@kernel.org, hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, jordanrhee@google.com, willemb@google.com,
 nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
References: <20260924185316.2831077-7-hramamurthy@google.com>
 <179036256202.2160803.12978678207911420221@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179036256202.2160803.12978678207911420221@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/26 20:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 (1) · Medium: 2 (2) · Low: 3 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] After a failed recovery, an unprivileged user can crash the
>    kernel with an ethtool query.
> - [High] When gve_recover() fails during a reset while the interface is
>    up (service-task reset, ethtool reset, flow-rule timeout, or…
> - [Medium] gve_teardown_control_plane_resources() (gve_main.c) now calls
>    gve_teardown_clock().
> - [Medium] The commit message does not mention several user-visible
>    changes to error handling, and one of its design statements is not…
> - [Low] This patch removed gve_queues_mem_remove() from
>    gve_queues_start()'s error path.
> - [Low] The commit fixes a real unbounded recursive reset but has no
>    Fixes: tag.
> - [Low] Item 2 of the commit message describes the old bug this way:
>    gve_close() during gve_shutdown triggers a hardware reset and then…
Low prio remarks could be ignored and we prefer no fixes tag in net-next
patches, but the first 3 ones in the list look relevant and should be
addressed.

Also please note you are supposed to address clashiko comments proactively.

/P

