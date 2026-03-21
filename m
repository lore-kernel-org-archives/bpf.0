Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C702ECEAE
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053546; cv=none; b=Kij3JRsKPZvysSi3TKAnauv4QvSFOrxzQ8YFn8y5T+xvgdvpPgCkkb9m2uU+bVt+IiVA6vumZvIUGz3Pkt2r7FP0s+brzJ0etk/ZXWEK1lywWP19WS+Ct4STFVtJYAP5WZBl8dHGU/JLD4hcCQBWp4InZR6DVclPU/vRxu6IRB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053546; c=relaxed/simple;
	bh=yfSV8JCn6AN544dTPrv9GzEX4LJxqfSd3fiWNhIPZVI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=swlpoXR5i7NIK4l319xguI5q0ZLcZ/pwavWfOkY5/SP6y0kwh9YJmE2EJjyYNs82m2vqynytJjac+cTl13pvYmvUfm06w7SfpYCxO6NLM8kbtOc9QouHdO3yZDO36ZN2j+3FzJhmAhW2ksx/A0tEBztsb4zJ4+hglaOm8Da5qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iflJCwc/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iflJCwc/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a2ee65171so11764447b3.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053544; x=1774658344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL+iGW4qBm9PVZRdE0+FGsMc4rkgxKO7lAUUgZfh2Bo=;
        b=iflJCwc/XFr5HWycV4xlfHMorfUzqpYfR/pSRQ3/tVi7lrcrrzUKY95BpDc+g37B2T
         eDPByTltXdP5C/WZp/LH9YDVpASFXRF0d66GSw9r89XOyoNQVRK2Bl5bmDodv3UaIA0t
         VYKxd7H88faqya569jPlZaHw6uwfT3dSN0X+mqUbIANpBAqO2n7MzIsxju0MhTyHFT0N
         YjlM6guN3T6nEjUyre5ZQNOI0yOv8NYp1d7RhdDWklZnMQHu92U1TQWPKkWj9qJWlgrB
         nmglUJOeddZxOQK/TzN/wSP7ms5tsw6Sa3Z60G8UfO6zwMaF1vQJR8IOQkydfz3Z5Pry
         qkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053544; x=1774658344;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL+iGW4qBm9PVZRdE0+FGsMc4rkgxKO7lAUUgZfh2Bo=;
        b=tDRiDNJlaSkMnAA58zGdEvzNf9nLAtMCjV/QirSSTjawwjarS1Xkxi0ujY2bjHfM2r
         so/pZzThQFqkp5mFEmXCzY4PiUakwr6HYB4H3uHO3LRh6lyUHbcmjttLoMm3ZeRMD/2T
         MZyCf74gYzANjjD/YGcHAyZxsS04jELOWcBBT5kQ7ym9f/BPTRBtXCoxvG/YzQ3cQbcN
         zp/b8/PdwVYpOEZ0wrBM4n5jpwRv+7ghvOSVOP/DNd1zvvekchrkCzq3aNKLFE/X/TLK
         w65AfTA2xn1cqblTIJd011FnBvjiRQ54Fr7WXD+3yw1dlyjH6yxG3mKemdIpEJUgoO9Y
         zNrg==
X-Forwarded-Encrypted: i=1; AJvYcCXTNY5Rx8IJ+Fa2yfuFpXSZLV5XGt2NH/MfTddccZ9oWDqLk1kvNPSlQYB52VPMsZIPja0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3ykXojdRaeJA2R5hJzoClFObXrccjql2xw09YMgsrsW5LLN9
	/TPFDSK+BwzOpaLDl8c7yTSosq8xehHdMlK+9FqY4i53nOXvImDCGySP
X-Gm-Gg: ATEYQzyP30erQgVxMZbJzCK+zwvdZPnuL0oPOQXsJpQGk/u4xysbgVk4aj5uFI2PjPg
	2VVNWz2+OiFGOBWVfqybq7JOd8Lo4M6c9DcIIBrOvPpXAsTNuG6dJn1UTxdkKZAlBObNwN+x5Ln
	U/IqCmH8PLYmFG54SMJ3jlLDC2Mi5UmGHAkEopLASMaQO+WawTCPqBpaNBIAi2r7VQ1lLVkclP4
	C1wZn6MgE+5hI1CQaWHC3nTA3uWawrq7ba8j/WwxL//e0YyMcvWcKncYTm3Scwqf4AGOsdPLnCS
	clm2w1s0MTx8mX1g/AyMTz5PMaYiMvTOwVe0ATHY61dldyZW6ShgsI9Xcm2NGrNeGLZ5VRS6m7V
	VEN56z6DC4po68SslCoHXp4ROp0/+VrYaHdAtw0GGf8EDxNjMhb3zP59etyT2samY6q5K4W4C0C
	2DVtm4hXTOcpttxoPwBbagJpMcqmLlDMJzcbWsz1BhJD96/JrOmSaruGqql+FHQag78p6afeIi4
	KrO
X-Received: by 2002:a05:690c:ec5:b0:799:1c93:7adb with SMTP id 00721157ae682-79a90af72d3mr53810957b3.23.1774053544134;
        Fri, 20 Mar 2026 17:39:04 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903a2bc6sm24627487b3.5.2026.03.20.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.25780616b4d@gmail.com>
In-Reply-To: <20260318134242.2725749-2-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-2-nhudson@akamai.com>
Subject: Re: [PATCH v2 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room
 flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
