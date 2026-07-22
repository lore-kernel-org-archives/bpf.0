Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E43DCDA9
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693466; cv=none; b=BCCMd8rtWYrXuqWntMo5+hYSwq9yTGFvZ/WIFl9ezoWxXjXwWYx8wWAb+zSQji2EzsVf1dwYWW464e+mCdkpzf/fXT1Fx24UW+tnz/p9i68Uqn6Kn1fXgSBpdWSnhiWXRiMZobcnPXlHV0/UMO6IHcTNQEziGWfIa2LDtwHQHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693466; c=relaxed/simple;
	bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTO3I0J3pB1IIlrI1RIzhAagozWS138B564ijYwQjLKTB0C3cKIxsXsjrQ6VxoUmO3JfoBGkY5XQdxvXeXIPsxzfBwGZ8ViAdaLW8+hiDt/JBuun5kJG3VgWBQvXwIQd42prg7AvVp2RsfM5fz4Pc0qv0nYdDLmf/zyP77EMBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/W0XBOe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/W0XBOe"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81eaf3709b4so100779007b3.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 21:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693464; x=1785298264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
        b=P/W0XBOeoIvE5YMUDqG7GI/X2hSRClFzsS4RQszBItqjVjit4TrYEHm/gxF2XUaMmy
         4jpN5fC2dT5JRMM3XtBEg7CszlSq4/oGXck4zz67tW76m52CLminBerbJqsxuqh0wzHT
         O18tynxolHZnmPJKFYWKV8sJvNJgE0xVyjLx0OSRsFCVSh8UJxGBTMSEdJzkf5UHSLXg
         ya0FnuqU9heDf6pqGdHWNLxC5hDyw3NOFl7ZJgumlkbv3i+HcJh4L0NQ6y1fd9sKgHw3
         0q0s9VfLNF8XOQLutpS293ITbPTnLFnqiS5xte/P0QcQan7vY+AOhDrElARsHsssMCPx
         g/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693464; x=1785298264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
        b=NQ32IFReLBtMGFIpS3rUY9yMPz8caANjr434gLbLd+Nm2++tdv4C4IBciXCSJlRO1F
         UnCamy5RAKaCOoOtYJSmwE+mXiSRDEnTgqeEiQElBQy3Yt8Hvo3Zdm4dvwVoG5p6wcgv
         oJojbYXdt0tCsQGrpVjxtKPDKf1aXaKTm1/hKztrSRCNY1fm5rmUcJMcdDC8MGi4Jwr3
         IU2gnlA/IotM8PkWx4bMyPt0EsZ8E8hjPSAvzl7AFKogiJWeiVbiXl/aQZOnTGFPrXCP
         vv2etW/BaMIZkr/6g/9L5XaolQAL81lDycVbUkOd8IUoXcguw9FZaSDdUXxXjK4HDb8G
         Bujw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4RG6ZWcS/DNQquhohs5PCb4et8JLRQdJZyXxZv//0bNdqbAXStvZUtoAbwxrMF9k0/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4dourKaZgNgmatcCgUtFD4xsWPbhPf9MXN52bw56RI7FAX6y
	rEnwSsVvh3paTIaHGrH7/7Q/yjo90tmcNSFD6/6ZY1Z87BXQsmC4D3oK
X-Gm-Gg: AR+sD13D4/SB6BW6TEPqWQZDGJn3mxGWWd5ogaiIH9+rTKBaTUKlL7cYoCqYuCAOdAo
	Ku2bdAYPpaw6MYcUVCPcKefEl1sbGeyHpfKi/oKsMLgbam1d1dKLn3ftf90K878FhueTLsLlrHu
	k8QplWpNATSumg298os8diVk9JEH86v1S5yzhaxNwB48uu1O7OV5oeUToT1l6ScCRVudxMqrtu9
	ZSt49dWOfvfRb2d3yqTg/qtgWMvn7cNsMkLqlG8ZHweDHUmnu0cqDYyHktqUi08dJnFxm8SsxBp
	N/VyhlHt6LxBtCICKz1ZaGrbB3A5Q5IyQfMWH9f6WQSXWvRFbgofPzBeVnvJ+lW6NEdqguUbkFj
	+R6UYnQS49LNDXGaE87X9ooHxQPb2whEXphbWs+OJOOE6hycThEDsDu9XFfA0jNOWNhZJhk/i+R
	0eHAbVpteuuWzGw+Lo3jMWKgAfIqlZKsrqwhfQe0aBqaLPvsbUGIBRUNS24Gnz7J9cxCEMSKeI/
	AfS/F5i12GE4w==
X-Received: by 2002:a05:690c:690f:b0:81d:edf2:dad8 with SMTP id 00721157ae682-81ef26fdd86mr67929787b3.22.1784693464016;
        Tue, 21 Jul 2026 21:11:04 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c6432csm7930537b3.20.2026.07.21.21.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:11:03 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sdf.kernel@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] xsk: reject tx_metadata_len smaller than struct xsk_tx_metadata
Date: Wed, 22 Jul 2026 00:11:03 -0400
Message-ID: <20260722041103.74925-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al6Czy7Gvhc41RsY@devvm7509.cco0.facebook.com>
References: <al6Czy7Gvhc41RsY@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the suggestion. I've tested the proposed approach and will
send v2 shortly.
