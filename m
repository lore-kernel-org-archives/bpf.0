Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18712181
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979507; cv=none; b=kRPcaMwfu99bxelNR51RxBZ5JAqJZ8VxIv5F+BDux8CVNs0OmCplshqEfXVBzbj9JXXtvDEsxYb82f891Ark1+fjZXlSkbD5+e+SIeIFo4ZEcJGsZyIXyi3ScKcBtcjW7tn/Rj1AkYS1vl35bsri+2Py5VZXVyqukSODbES6/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979507; c=relaxed/simple;
	bh=/l4NgFfWtYMzxsxpevzEI1hY2+l5XOs/YXqMKaFpjHs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TjmKiP5qnv5KipFJq3c/IoC+yXuayMmwIiZmc01U+r0jYC+OHrHdM1akZP5k+QOHT4bq3TP/UHTAQdNUchAUqfbTLIsnGBF4J8sYFXxsZvPGt4ur5zsl1o6rPUDcAicSVp+f2jisY3FD+qGRGB451eFmdAUlmk75JT21XwiecpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFUxVk8y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFUxVk8y"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1deddb82b43so73875ad.0
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710979505; x=1711584305; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/l4NgFfWtYMzxsxpevzEI1hY2+l5XOs/YXqMKaFpjHs=;
        b=wFUxVk8yhYjwlrhpO2jablQ0qPU//Xf0QjcUYTp7E24zvT+J8U9cjiodNc6c5an2Fz
         cM82hSZxHlVGwWdPBAhoWBuWe7RsCIsNJZY2ynAyNSBv61P/E2jptdmvyGkelT1sfKMZ
         8BvdH5zbcEIuo+C8s1o1Z09X8aarvXoF5AnyjU72q2UtX7N1Sm6k95fZ54n6qrfV6vq4
         KiqHSUVknP4YnXG/cKy4p72HSzrYpcbXVtkNTog06nbYzEyMw1VcGwvP8VmsehUSak5k
         nPtt6YVtDx1aOgP3U9VRLmzXqTCf0CF8mV0fo9zo/0J+yDxELh9DA5BbtYVrSy6aenEX
         0CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979505; x=1711584305;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l4NgFfWtYMzxsxpevzEI1hY2+l5XOs/YXqMKaFpjHs=;
        b=vx+OGK+DsPQYI5yetgS5How8T8pf9nMRCp/hEwC2I2eKkVnu+WiTutcSAYQMSeN1X2
         NaJ7JXqY2t+J6VSng5Jka6wsnxVxbmssJMWmR6TRdX+9tWVEO0i3aj8FnubdJfGGT2le
         lCLK6ffehrZ1XbHodxojL9OTQdAWkY3jJsRUXEhflouQD2oilCA+Z2PLJmQaYowOBX0r
         BtFwGql8AwITm5mFHgrPY2fhLdZt3CAIDoUojPXhC3AGiJRaBBEAE23zxpONjK3Z6vko
         eCv0ebfyEVI1lS8SPmA13oRBz+zZ2Hc9+IN6bQpxmJ4AbKIiM2IvI7kLPsMZkp4mblzE
         meWA==
X-Forwarded-Encrypted: i=1; AJvYcCWVjEANT+mxZyl1GnFbqpN3oicWidfWyydlss6CfIIhfiX8l7A7vyTwtZKNNKrruT9DtO5BnuvbeU5vLnzjKUxhvBXI
X-Gm-Message-State: AOJu0YxhbuSywTwNq56ONf/jFkJJLg+0BpO3XwClAym+/Vm23g9jbmvg
	CiMWgOOzTjvd4f7v4ZsXUfpHl9YExU1Hk92bx6NOQ7bjIniIuopfjbHNK88F5+lOsckPGx7TFpw
	OZA==
X-Google-Smtp-Source: AGHT+IE1DeLxuJMF7/WAaMKquFXnl5lpDa1mEKfRHpxtVJC+j2E9qt1kFN89RM24ug0gU+dkX3flzw==
X-Received: by 2002:a17:902:cec9:b0:1e0:1a1a:8662 with SMTP id d9-20020a170902cec900b001e01a1a8662mr47580plg.25.1710979504976;
        Wed, 20 Mar 2024 17:05:04 -0700 (PDT)
Received: from google.com (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001def0c700e2sm11892081plg.119.2024.03.20.17.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 17:05:04 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:05:01 +0000
From: Neill Kapron <nkapron@google.com>
To: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Implementing BPF_PROG_LOAD_FD
Message-ID: <Zft5rRCNZI8YQu5p@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am working on improving BPF support in Android and presented at LPC23 on the topic [1]. I would like to attend the LSM/MM/BPF Summit in May to continue the discussion.

Unfortunately I was pulled off the work for the last quarter and missed the deadline for topic submissions. I would like to attend the summit to discuss the work I am planning for the rest of the year, specifically around implementing BPF_PROG_LOAD_FD. This mechanism would be analogous to finit_module, and would provide a way to support verified boot with BPF by enabling the kernel to load BPF programs from a verified filesystem. This requirement has been set by the Android security team before enabling other upstream BPF support.

I understand that this is not a trivial task, and would like to get input on the best approach for a staged integration of this- starting with the basic framework, necessary libbpf additions, and test applications, followed by porting features provided by libbpf (like CO-RE) to the kernel.

Thanks for your consideration,
Neill Kapron

[1] https://www.youtube.com/watch?v=UM_tnuZhmt8
