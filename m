Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393240BCAD
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099097; cv=none; b=T7/UdvykByNTogm6FHTU9+C5pAEoyMWfO/He6FYjJdHGi81/q1tBJYuIq6at2jZyd1ddpwVxFwZMfxkQ+pKXXE1bDT4PitGuLNPpFKTUqqvuXhdcw09C7QGAmvwq94aGyAP4hqmR3cbfjlq0ByVMZOnnN8gHOeuVaebAGXSzIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099097; c=relaxed/simple;
	bh=pIKr+f7SHAgP+TcmEWYNDpdjqyrYirdvxHbiE+PC0TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9DgldCQ800OHJR3Yy1U6y86cS56arQ0UIXQDhHnHPZpERR5EnhsAialVne9auJxdVIaqH2wtGaLKOd0FpDhTnRaJ+Bf8p506X7kA7wvHmRAVuZjg/DLW4j7nB0vB2Eocm3OoC9tfhtHj+cDp+5x8g5WBfyrrQuC5sQgB+BDlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyAZOCpQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyAZOCpQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so3394887f8f.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099094; x=1781703894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yJu4GWXEjspPhIezkRFpn6+hkFDzwgslLfP1rS8cOdM=;
        b=fyAZOCpQvX1+UQaeAf0tQnTOD1n4Sjo0MTI5Q+XLKy7sgQW+wQNiShywFvjwARusPY
         1DU4dxJnAG4DOgd6eXds7D7pG3i+ANkDhgZZrfgqiNOm7JNPoA67eey9Uzxye6TM6OXx
         6F20MRiO4UCJwy5m4nuc/kLg0zFrh6njTfV1Urjctd6I6FWxrcUuKHDztt5tyOm7wVZ+
         Qn8g+d/lpUusVQ57hsxMvUjzfuohuxTqqF0mznYN9zL1xqJq9VynoqfPpK7JHutj9iTH
         uCRlcDchm2clSvgQYA2cUIQLDvkL0lZfyUuBtDm2SFz3NiI4Lcs/vl7ORvMqiP5efBvm
         pDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099094; x=1781703894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJu4GWXEjspPhIezkRFpn6+hkFDzwgslLfP1rS8cOdM=;
        b=G3Yy2H7MMTziixiGfXdFkJubNkvZGlzy8WOb1OiFseiowm/uDc/CHQWOxC8dyttXE/
         9xcpd/nLiHnL4X7b+w7F6VGrb/6x8QKFcvYFu0Vo3EPLh3D2F81Zp3mUgygTw7qSJ/cd
         8q4jeFs8MYbf4ityWLEb8Xf2xov0l0OB/vf+xb+qJm1mQxqsC43heirgOE2E7QB2iuXv
         cHJzxYoFA5nK6QZk0x3QYR6pFaWFlX5uxHcU6xICAN+HEOa5APbZFXlTJD/o+2uYBLxl
         NUct2O8rAHaZOTazqE6Av5BD/lWPAhWLZi9B1ddoWV+ZirxecvQO5iZPLDdkPPQkBYc4
         IwOw==
X-Forwarded-Encrypted: i=1; AFNElJ9Z8y3YBxyGL1NyQLU61nwhi0pXASRcnIkzf9ArkpmLFB5bRGBvDsFFJyy/AdDTgDueDVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXzeT/umZNm27edIr/xUIkQhDXN1cMMcDQKGUPK7XRsiMNq2T
	nwjjFoWqwJJ4iHXHExB7VArZPO5kvo9w/Vw9Y+8ea8lR2ZqTA6AWvVN2
X-Gm-Gg: Acq92OFQB+0opP1G3TLwIWAJI5+93lGFbnbtnqDO0lhJ7QJjvqYaVov2fZdhdC0RY6W
	QTNwjy17D+Kcd6dRNYaHrnwu8lpJpMuabiZhDqpIBlH9dHcxVFYm2nXf38Fwpa0zk7GWkiJ7U5I
	yR3kLRyC1nwPIrXr94e2mh89+dHbjmgN+zOxDTGZ96q0I62ysLcDZnUhR/dNPd+dVfhB+rHuKD/
	AGnqNU8/81ERRMesoS78Nq5tQhEYD4fq9QSfHU0+/ZICpnNimQ4an4UWxqOmwjo/6Lr6LQjWsus
	dl7+6KT0V5Piy/tlyuGBhFiZh6BbDWEIAuIecPJ7uUBt9xuKuundPmu0v/8W1jhWZDoWPk42vPH
	bYCD7oRJDBewrl6gqibg7gNUVeDkNMxKSiQhmltVM0P6U9u3/5LUnsD7DL1anF8IiJhhenKTojY
	wGbdFGGDPqdaf4xedYKqmZORtZq8tWWCP4k6xpFi8+EAKGODQK4DludbTklf1/+N3CQRIzsTCT3
	wT4FO2EMcpBjx0mVBOxDRP63z7VRQ==
X-Received: by 2002:adf:f183:0:b0:460:1e5a:2267 with SMTP id ffacd0b85a97d-460304e8b9bmr29117746f8f.17.1781099093784;
        Wed, 10 Jun 2026 06:44:53 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm73852062f8f.1.2026.06.10.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:44:53 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ebb4fb1d-effe-44c6-82dd-8223b36419a1@gmail.com>
Date: Wed, 10 Jun 2026 14:44:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] bootconfig: render embedded bootconfig as a kernel
 cmdline at build time
To: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org,
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
 <20260609-bootconfig_using_tools-v4-3-73c463f03a97@debian.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260609-bootconfig_using_tools-v4-3-73c463f03a97@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 11:28, Breno Leitao wrote:
> +	depends on BOOT_CONFIG_EMBED
> +	depends on BOOT_CONFIG_EMBED_FILE != ""

Hi Breno,

Just an FYI, this dependency on BOOT_CONFIG_EMBED is redundant because
the:
BOOT_CONFIG_EMBED_FILE != ""
is only possible when BOOT_CONFIG_EMBED is enabled.

- Julian Braha
