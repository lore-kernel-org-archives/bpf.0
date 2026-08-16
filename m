Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E62D5925
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867778; cv=none; b=qXpEH37Zx46r862dUmMcGN+DGkA5Slrc/Z5TomoobUrnzTr9bhuulLFvlw/Sq7/gtjMq8cMxTZ+XCEgMT8zgwXxS6JN1SuBCfXo8Wo78qn/8ICx2xnIic10O2vrITKKXexiwu2SAe8kNiNCRwNc8ZsLQpb4wAJrIKHCnsenRhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867778; c=relaxed/simple;
	bh=phq8zqQFtAPUYO+svcVQyHd6V8oJ8+bjxkVR8gs/0MY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnDfKCTIJfMZcTqxHRX5h3XbfyNeieqiY/2EGHrF9MVhW0gzi3q4pPRtiy0yDLOA/IPl7nz2fZpYdPRrX5vrBH7/lHsXfIrEqT0Yx5VveznTQvH0Ct5q70w48OlmPb8DwjCPseYMqZpidM1tn1cRPOvp218x8TAOhi4d16mm4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVnKvN9f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVnKvN9f"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso26127015ad.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786867777; x=1787472577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=phq8zqQFtAPUYO+svcVQyHd6V8oJ8+bjxkVR8gs/0MY=;
        b=HVnKvN9fgjFv3ywpWGytdCqJDsq7e3BVePakq42N8Mk9QpYbimOdx8TzACP83Apusw
         xhlDDie6OCFF2sK4/G+AhdQSXiOI3Gor+Z0eclpWylKxsTwU0DkegrZ0KJm+fMnmPthy
         EEw698sknAVypl1FtOf5umFmo37rdCozmrYdUowmlxRBS6opmzvgjVd5SArNdmFxzgFw
         wkcmQzd19AXQMQdsAc/79EqY/JshuZsaiYwSfI66Ummsxk8omG6QS0SMWSQLeCsDcBtK
         RoxAvJJFwcVqgb69DsYOaSZgJOSNNpiiXXXubGR7gIaKoUvQKqcHdCEIyLGAjz0G0ppL
         TZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786867777; x=1787472577;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phq8zqQFtAPUYO+svcVQyHd6V8oJ8+bjxkVR8gs/0MY=;
        b=qaq80m3nzBC8rAw3pv0tGZ+s/jB97SPbidAn15LXWhQP+lzHQfJ92hsjKycgnmMxCi
         7CNwuqq5ovpeLByBXicu8ayI4fBi77nhPquR/I2lJP0ClPnwFUQeYU+4JIR2QEtPLiXD
         DLAdw0gniBMEyJ6DW3j7bqpkEADqEJJCbWWFDHWJtV4Foh3MrfCVHl/0F3IpMd8x+0oK
         0ZQZRn7BiXKNdXTSWY0iVsFV+6VN0MVCIOks3EfHm8ErexMJr2Q/LxJvwFOmxuG3Anl5
         ANq1KOBIeh+3fnt7R5eFIj2K50PSGFWe95WnlxyLFSv61/u74KZsK0h2J2mvgV2JLCzm
         xAnA==
X-Forwarded-Encrypted: i=1; AHgh+RoceOvW0ls9KXvVCacAXEx308iR6Uj752XUerSSfPWpF2A7Kh0ZsEO9Vmtv34U53mUyY3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72A/M72KrezwaYpQkYXMa7tL8n6cnlPlkF7KhRuf/i8scSwPe
	54uTCKRG2xDgv0oe9acUbE2bDSWnBnxE6HabX9wI3fH5yRbV+81b1Bx0
X-Gm-Gg: AR+sD11BA+HbQQ+kt3F/7778AGQX2t13vUE44jV5RmG1m1W6AFkIB7TeToxHq5lmW9/
	Wjs25/8eNiRCMI0IpRqa+kbkWqOoy/A1VG+qDJYwoOqcY79vhorl90IuRkGSKgAWYABJkWU3ceB
	ZEggXdhPN2S2Cbc9DqkfdYi1j9srAbJto9H62sQwSNvawu3fv4im9BETkOZha6oGVTa2pOnLHSN
	PwfIvvf2eqQJwEVGos0N1/CcyqeNxS9ox8nlMizpttxqabtEiUiE7mOgqWbcX+GMGJOJ+XOg0oE
	JTB2fEDpQejvxg9CRvn9cWBzNh71hDjc0LFyLstwSLukCOcoQmzTg2Gu5Ge/h3SK5soVoZPmgiJ
	zJqh7TeLGDvEL9MaTowrPwK2pRQBkEcqU/KcCZKUdkPaMzvgNdek9xUr2QeJ6850xUGRtHA/97f
	Os2jcwq6NPtxP7dUOthTQ56Y/k73+c7POeGGw3NHgnbwHQ/gmjwfxgncpdoTXv7LPOztrS3EmlA
	SDo6DoZyQL7yDu6hBfWlbjoD2w=
X-Received: by 2002:a17:90b:3c91:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3933b78e3c2mr19643451a91.7.1786867777061;
        Sun, 16 Aug 2026 01:09:37 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b1edb2sm3880175a91.0.2026.08.16.01.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 01:09:36 -0700 (PDT)
Message-ID: <bd4717960fc78d2b98593f8fb5f7f2f36a668ea2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/14] bpf: Distinguish function references
 in policy diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 01:09:34 -0700
In-Reply-To: <20260816015746.2632990-14-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-14-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> add_subprogs() rejects both BPF-to-BPF calls and BPF_PSEUDO_FUNC loads fo=
r
> unprivileged programs. The latter loads a subprogram address for use as a
> callback, but its Policy report currently describes it as a function call=
 and
> suggests avoiding calls that the program does not contain.
>=20
> Select the operation and suggestion from the instruction kind. Preserve t=
he
> existing call wording for BPF_PSEUDO_CALL, and describe BPF_PSEUDO_FUNC a=
s a
> BPF function reference.
>=20
> Link: https://lore.kernel.org/bpf/d02e6a6d3b2dc43a207b8ba836ce62497b250de=
de9252e7409c5212201c794b7@mail.kernel.org/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

As you see fit, but I think the original bot complaint was too picky. I'd d=
rop this patch.

...
