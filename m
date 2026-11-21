Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300927;
	b=Q0wulj+V0go+xlaOsr0HusIK7BXEXmGnbgexFpY8UsknevaTwQiK/A8nkof1YjpJzk8p
	 L7iRxO8BzjYqYUqQHDLEhGlvrIkFdj7I20JuyevuCfB/x8EEl4fs3tilFnmb/e6FKBl9J
	 YNSw30eWK+igYy15xYtO76ZsQ8UEZU6M1ltYpVUYZnnh7NQDa/4FbTf0Gg7YDPJ8s5LEf
	 FQbX2lHtTth6yn9Qh/cB89/SINwV4MoxwLg7mABGutE31khR2cf9oc5KxyUV2q1uQH8s/
	 xdIytFHytQN7MuzwhJ+Bk7pSyUav6lCZ2nFElKQJ07E8fIi6y71EDTXboBoJK3fVmRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D2UwN6uj+eBii3DP4gkFy2CXb9ETeRwrQjxMZhSvZ98=;
	b=FMeFDW5/tbXOlIWHUucXz4/SBfE7mprzOu6jD0ZufhwYGQrVlSaifmYBHrcnl6Qj9oQ/
	 1aSED3Ox6XfTXSWuRrDXGmldfm7NB6Y+PSDu0BPeJDwJdO1n5u8AjPnKNQFKf0P0cgm6/
	 yxqcStTTpL7v/lGL8Al0inUX+BTrfsJWmMmTLNiAy+xTwsTjIm/UKOrFqc8ZH1vBR8u1i
	 2MWBkNiIZprgVFmUYd7eMj0Ow9SEyTCZRxp2lhhBStm/AB0Jd4M6b8xYm517v1Ee04tLF
	 0i94ttEQ/1pdNQwVIBfSfR0xj8twEkgL7Eae/FDsK0JuWIbis+x8DNbBUEZwb0QCToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0axLW/PH";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD2606A330
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DD2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0axLW/PH
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so1914235e9.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795300926; x=1795905726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2UwN6uj+eBii3DP4gkFy2CXb9ETeRwrQjxMZhSvZ98=;
        b=0axLW/PHnotmGnAGvriUDC4zPVypUAFY7tABZ8TS4udy4Rp3gesnKf544GmlWlkSvq
         Dz0WU94DJEvJZAHvyDnh/FwYRdIQnMhzUYH5xXDSX7Et035M7FWb6nSBqjZ/YmeBBAWw
         LWlHWZKotM24upMg5sRrNLLpTrOg6pZDIFOE8DO9mnyDYjhKI8wUJzqiQlVRK7/2sgqE
         FhtsFRgAtArM/jmmbb0bhrs0U9kRRYzs0uHpInCW7Vjjw+kmF/iXFo/huHD1Y08DCSrB
         GAeijSHYKnDzfR6CRpF7UJFF0EGuufD7ohLNuTq6xWtMqsf2EeShpUbuZqfSMaq4wJHX
         b4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795300926; x=1795905726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D2UwN6uj+eBii3DP4gkFy2CXb9ETeRwrQjxMZhSvZ98=;
        b=J2p+P6YRHfYWcIqOyo25ZNnGLRL+Q1/69s9g4BHfWMinRdZnkAzruB9vl+wdRr5C1T
         92bZvxEuRTZsD8G7ksTS0HcmVzzXHesUy97ZfPSnT8K3CUAmHAxN5DmLpx0yrIRDyoAk
         1Bi2rQyJ2KygAif6YoS7HXI4XMWDc6hP6YfV7+Ki/fQs1kYE+tKKNxcYfO+JiFbeZeVp
         m4l6k4F7MiJXnGqUMALTZE1V4Ievz0V8hF1g4uiQJ702Vm4oBZ8+B/YWTIOa+bcJCI/R
         dq7BO2EV9TWUfCj4btPAL2GZ2ynzSpJ/AutFkQcNshGrL+nND7IB0zE+/KGKjhlGb96j
         dZ4Q==
X-Forwarded-Encrypted: i=1; AL+hErHBg+ddJXNAjGY6Os1jf0zlqzME7lhHR1YyyrannEM09cxmWIKmeEqywcSexDfAUzdliMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kvV7y9kjLD15ShtvGJ3HnUACfblHv8eiz0By+J7RYc1/hqUsz
	WfqpAqI/gppovCPUWDcOa1ycqOQqyIu9AzgnaEDqKlWf1FOYd9SRghzH
X-Gm-Gg: AZFdTZcsk/y/SlyOuCrRUfpfN3Qnlyj8Y2xHMZWGQ+pU/wb5d0rZIQL1p790gx2NtQR
	ytobcJUS4NITUpxW+VWDvh6Ka56rg2k0i9lScQrzFYR8HBZjyNEJvfOto+nzcYFhfDYJF0uoiJa
	Itly+BsHDzwG2r7v61Apyuok301xHfpTTk6U517Cb8M9fkzKYP+WTVlIi+9hn+BxJAS5qKRRyqn
	CH8+ctVHSIQ8p7yGNTqugRPsyY1+bM5euZDR9KPHEBtYH1VJsZ2n9JMW1JFQyPcWhHBhAGmJbir
	kyIsVxR5Ug1f/oAzoBwiSmuq90sEHXZqxvLbwC2mWEUUWHgZOwioPkQfu+B7NbvlxFqspdr1BSW
	vkLDZJhKpf4vsiG0DVKQMUHuL5ZvE0SyOwpc0/J7bXm5By//5+qEKhFZdxE+wCpi1ds0wXznEcl
	0L3LUxYjBKHSwYic1PitJS/JnGmIxH8x8ofdOJ7ZX7vQnW1tSqY3rGBK+NbxCkp+GpJVGGQ0yIH
	DHhVcbeLGI2DxXfuDnoXsDANGUvO5Xd5KPXw8XpFQp33+4TufHZUO/XJtq2w3jqts0BJ9fREnuM
	YYHBUmjO9uxxsNtJl7wMMgjV7R7F6Ddghp3INqHkCKEblzG/4D4aR5TZPu5JRk4y+DC6xA==
X-Received: by 2002:a05:600c:154c:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb887f43d8mr151053725e9.1.1795300925668;
        Sat, 21 Nov 2026 14:42:05 -0800 (PST)
Received: from Nuel20.localdomain ([102.90.87.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm56649275e9.4.2026.11.21.14.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:42:05 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: tianyi@cloudflare.com,
	hangbin.liu@linux.dev
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	emmaonana18@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@cloudflare.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net v4 0/3] selftests: net: veth: propagate check failures to exit status
Date: Sat, 21 Nov 2026 23:41:05 +0100
Message-ID: <20261121224105.6288-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119012940.32838-1-tianyi@cloudflare.com>
References: <20261119012940.32838-1-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 01:29:40 +0000 Tianyi Gao wrote:
> 1. Patch 3 lost its subject prefix. It went out as "[PATCH]
>    selftests: net: veth: derive invalid-tx test value from kernel
>    max", so patchwork put it in a series of its own [1].
>
> 2. Patch 3 should come first. Patch 1 makes a chk_channels()
>    failure fail the script, and from then on the nproc + 1 check
>    can fail on a correct kernel. With the fix first, no commit in
>    the series reports a false failure.
>
> 3. v4 was posted as a reply to my review of v3. A new version
>    should start a new thread, and its change log should link the
>    previous postings [2].

Thank you for the thorough review, I appreciate it. All
three are addressed in v5:
https://lore.kernel.org/all/20261121182217.4609-1-emmaonana18@gmail.com/

