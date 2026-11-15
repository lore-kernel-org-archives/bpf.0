Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780173;
	b=sxE2xxewfeCl0gMNPNtJYxyOdMRePf5Lk6V3EReJTTztCvM9/JB+tgoTruP/ox4Aoqah
	 wjBlf3bt2+gi+VW30x6ObiQrakN/RhOk1RW4Kqg52TGI+a/kOK/VuDe8GW2Oo61AF2lmo
	 KDEX21VYfawFOlMDh6jTOL++QHLSdsnNThg0KQFRG3vroxkR+GxCnq8o+PntNXxp5dGkd
	 0sb+T6za7dKQ1uo5CAOAS4JMgToXejEul4/hsjS/+JXcyFgXGAE2iPgD7wwn/ZEeA91YG
	 gVvORGuKHBRzdRDWsoLvvOgX4vZJKBfdO0bQOq5BwtXs7RE8dI3xy3XL1rqn1c+pyCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=44GH0xmAnqDy7eYWEVRDMZZHirfXjJwNhusMFmtNtQ4=;
	b=cdIJrqj4KnxqbGe6AqjYVAdBLx/iCcsTe3S5PsBFoWhX9LYXLh0fXGoyGR7PpJs+MRCo
	 IqgeIF5Dx5trc1MivjWzGuWAkO3LefHJjw5/zC7ZEGNEoV+TskNwWomlSkY/wOUHjY/2U
	 bADXYkenRBdNlYdqIExD5Z4TMO9EnF2jA5pwexbYLBGrntwf336wcrE7vk5WCxnE3lJKY
	 UbuWj0oqiMna91L8Oy7yt2cz+EaI4Z1ctCoRTb+JfP/XVZfhw5S/S9HG4HPVltphcDsY2
	 OCxG2CRcVb40WxvM/goMfYfQnZrRCBfI+PPVJvY1GR3a9vrVz8rZAKQyVUv47Rd27Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMa6qxkq;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FB606A31F
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 22:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E5FB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMa6qxkq
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4f7ccf4so295004f8f.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794780172; x=1795384972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44GH0xmAnqDy7eYWEVRDMZZHirfXjJwNhusMFmtNtQ4=;
        b=hMa6qxkquxLiBeveT81zF68GYb6CJxnvwU7kp66SYWYPigJcJHz6TmqT8tw5C24616
         bubH74AOXFvkcsGJXAFfX+ArBiWMUTVrjwhG77MzAp//sMX8SaJWiVMX8xbugTLpX139
         ZD3e/ooXqnWaj4k3pqkQZ7Ft7ethobWskQqXiWlTzPS6FzQTbXTCs9YNkLUKd2FIgb6A
         i9BZFyb0uuNX+i/i8CL3owRjg6mEGQGAjW5xHEdX0acwezoshJsS98dWmUMYOXQwW5HQ
         H24EeRiAZMJWVXcOJLOP3bGlk34c+aIjKvF4zN+3LAEJCNcrZVfT3bqNH8kene/rRrWM
         7VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794780172; x=1795384972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44GH0xmAnqDy7eYWEVRDMZZHirfXjJwNhusMFmtNtQ4=;
        b=tnGD9tJXE2XqoM5LdFzK7O3UmOYxVTH3bGkQoJGWFpfKbBVilZOXwCYKRXN3Jit3mP
         IWUZ38ZGAsdfmllbYQT8Dyrox7a+M35x+SeZ+rNaQlABCUT5Y3k95unBNpyIpsfFrmYS
         NlF6aSl8B0fWc+kMAOcLUFIiWA6qL6FsuLEI4LE7ucMy7aVfO1V3cvK015dlxRb2q6GK
         /g39pFVkVete13H/9LAVzaFREjChZYwQKE+Cjmjqs9MgscXssAATrSwSQqeV9onBCLSZ
         mVgBAo6p/vRpo1QX9lgaOvWyxOyQo1CQzhN9G5/4GaR8t0BzHxGhrS7f131QYYBnAwXY
         Tdkg==
X-Forwarded-Encrypted: i=1; AL+hErHkiW522I19hLg52SBVCJtwIoHKKbHPDfxEZ25k4U9h39YrZ71JkfVb9jfjZoRL15eHrO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KJSk97IQcLHw6VN+Dx+G+r+cVsspjSYHCF0anmkm35vnGT/5G
	ce/HcKG0sanrPpz7xYQrh7NH90YH5NiNUb3KmeTFXZI7xo/1vh0yfvjb
X-Gm-Gg: AYBFou1Sa+zvmxLgTKKNPY0nVHvea1UuL9liUTysSDlwzhnRiCiXzXZxkjLdO6v+ihD
	JU924jrwrF5nee9UKUbub2awWIurHepCN/NZlJj7fDnX/dgz5E23xFzpWGNMNiWKNdMDR1+pYNy
	t5Ny0y7xKdeEAQ4SaOQsqic2l4M7MPdjYgPRJVx6k4VFiOHvBRHZiliMz8XdOR5Rb3YwsBw9UBO
	MetGeylWrrZXXSh3Qs/KDv4walQUTnKAqWPZmUxFm4uHC73a8LtkObA1gNea8++2bdwfp/LYDMT
	DbSt/haEyNPrdat+CA785Uk6ie3s1Lmc75etBhEZ62uyD4ta08o3+ZYybM6yRNINxX/3a+zTPry
	ekBaj9V5vDcXoC8ZeMnlKjXAWnIeWYEbhErtNUwXxqvMeQ0f53XprWO2PyxHF+ykqyBB/ig68BG
	ycXN6mHBoVocTjcrHNX2n1kPq20yHgYCpndcRYHwxbKHzQyVwSF5LCaZ5jPzXDR1V2/A8OXGflq
	hVQ69JEiU1aqZQ5KTjP5O6Hu4mYHQMYuLvTxXNSzWJf+4DJh+Rv9fYBHUe2cX2FYrGDYFk518E0
	cZC1aHS/CShnL330fTemtOPaLs3pAr17yydrabIksMnKrj2lDzeWP8Vn/8lM1lB0uJYHN6OWNnh
	TTsAcwIHVOws0xhUqzj8=
X-Received: by 2002:a05:600c:8b74:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb6a02d56cmr58017955e9.1.1794780171572;
        Sun, 15 Nov 2026 14:02:51 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb734b9f44sm9320665e9.1.2026.11.15.14.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 14:02:51 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: tianyi@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: Re: [PATCH] selftests: net: veth: propagate channel-check failures to exit status
Date: Sun, 15 Nov 2026 23:02:40 +0100
Message-ID: <20261115220240.51713-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAG4wq-exUYFvw4i=gQZhwC8fF3tnhmOMtv+NceYTBEx_TO+F7w@mail.gmail.com>
References: <CAG4wq-exUYFvw4i=gQZhwC8fF3tnhmOMtv+NceYTBEx_TO+F7w@mail.gmail.com>
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

On Sun, 15 Nov 2026 21:34:29 +0000 Tianyi Gao wrote:
> The Fixes tag should point to the commit that added chk_channels():
>
> Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")
>
> c017800af5c7 did not change this helper. The bug is present since
> v5.15.

Thank you for confirming. v2 already carries the corrected tag:

https://lore.kernel.org/all/20261115214702.50817-1-emmaonana18@gmail.com/
