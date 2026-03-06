Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0562494FF
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771199; cv=pass; b=sJUE62ApMiwZGIBjJPGP2qSCYXz3sSclGsvzl4Np0X87xXOW+e9YGZatzI4Y/VK2bs9+pKDC0qy/0ZPm0J4sEbnYPy8Dd1RpibZkChT1QaaRERggcGSEb3fc0g/ib9R4NIu9VTRQtMQb3VFam84uMf++zLGxtqJGH9CK/LzWWDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771199; c=relaxed/simple;
	bh=QimF/wYEQUswSq6Q+/cr+k9M+FmDkXHmabFqpmToePI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/pDRDGgUQ3iTbxO92VyV6X1ImrwnZ5OHM7IhLUOOJcZPDs1+oMvGUOG2HlZIaLlm/j+ouIe/XD+y1m2J61WWq0nPxStymseVbVgSiE8qzKgXqiKC3dj48cM85NqJFmQ20lIHbsCXdqQA1Z+i+XJ+jGDEatEVmpbSae2M+L2Yp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1HM4kPY; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1HM4kPY"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3669266f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:26:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772771197; cv=none;
        d=google.com; s=arc-20240605;
        b=TIh0IXqeArjn4rLxX91Zc8frtsgadj5M06X8EiQsB2VLxBOw0Yca686ayr/Umxsl2m
         IO0/6VXmm759L9VQVEKc+OeHjBXui7d/nETIlk+LFakdeuL36rPJiptDp9czbH+Xo6UC
         tsn611rZe4jwss1bM0yDqva7NxUbxMyWhUeCIydAVCi9i/Jrx3Vcx0RviEPA3DyqFqEH
         qZx799LWjiDjYeU1uIN04LJNEX8q6gV5FYYlbpM2itZRJiYbvchNERC0JXwdkKpjJF+h
         wuIELFqmuIa03H+gZnlpRGSt3VY8hfEc6OtNytrFTpszlNA/Wz8b9bjOc4fmi2uZkzk2
         oYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QimF/wYEQUswSq6Q+/cr+k9M+FmDkXHmabFqpmToePI=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=JrYo4p4f21EH2npEojf+R7S6Tuhy1eM4PhNkgUO6cRanD4/ZPMqprpFJORMOp5DY2A
         yrtHn06KLPR3y+qIDtZNbj6L6F5uAs34LjeyRfkD6iAEJOsHeaNt/+NPvPhbdUUsxhis
         4VKLmjKDR164Txj6/ZZzD/h2CGyQki30DhhkdCG+5bGYYjuvLm3jF3MLVT6e8spXbgwC
         IdfmqesDkVfZq/5FBhqwZZUI3UBgnPAUArG+hdEMz1cxtNDffDhjxzokLeAYlKnGxV0g
         43J2txJBa+OSqSaWtKe1fOO82gDvJN14OtHbZl2/zvyN4cGmrxfu1R7BO3ifsQ78RbFn
         xNzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771197; x=1773375997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QimF/wYEQUswSq6Q+/cr+k9M+FmDkXHmabFqpmToePI=;
        b=D1HM4kPYF9maGoWdihtu6cnP9j5saaqHr2ClWaPMKkmaHNFg5sFrY2MufL6z81Wn4e
         m2OjkNXt60LvKlfvGYtaqeUIGQzbyiLK29+4E0087VW3H9D00HJjCKIh7liecyfkshLl
         WL2xLgsummMv6o3QFGiHNdRlDF3wNvCIbV8uDFIzagU/luHKB/o2sP6HTr5pyCkbw5WW
         VhIapD6YbvSKNI+6ktXc/5ARZWdElAhBeS3cr9o/BUmd/oTO1mJsKETf6GWN/B9LHDRp
         N1Y+QksoSTmQTua3ckwqGPSCcrI219gIqpepaKvLYsRXWvQCrgqIs1G7zIyWFZ+hg3T7
         +Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771197; x=1773375997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QimF/wYEQUswSq6Q+/cr+k9M+FmDkXHmabFqpmToePI=;
        b=pD/XUfPWAY/3bYXKjOcH8ahZDHvkViDt4i8dSA9fiI3/mfq6PSHwi28NN6igGPCylx
         9YWZqKVC8j9VkLO6xqQPmnaElHKcPU3b/R7iRnAlCtbuPyuGSfLyLJiYjdxmWD6DWb2a
         4nlKpuG3Wiu+qWOlHO+OPc+hRPJvSwEBelyoYXEnx9YMCLDxBSRtvXG/YFt+8TfjskmU
         r/CKFlWptUzWdGlAQP2Ez6VN1uHXL+s4WEfL4G7M5494CRtJo2CJcPdGa6iQ4cVbrdwB
         ASs685yekv0PtUDdsxGfiGShsVqzvrnNFkJu5mBgDX/S3angWvfE8ZW1qfTvTI2XRhb5
         yz3A==
X-Gm-Message-State: AOJu0YzKtNkhzm/ilb6fVikdtim3Q44ETAQC6OyEy7zRtbh0sLQaqPTH
	E4KFAtMRPSDseJ8A7MYOyhf15VDJAnGphNC0xInft0ic4nONj9UxKJoNtjnlHQrIzFcxkDQXlis
	/qOFO8v/VBW4ROximx1oJylOymTXysQw=
X-Gm-Gg: ATEYQzzGMoaQQa/1/JV3jAhwTjq4B1xp1bcy0tN9rzk9vamWlE5qR/gGAVzosF/XkDm
	/WYgUBNZzOS0GvNpZpnCD6uvMJOV+z1Jj2ry5v+DoRze9wOIATXNGvb5HzB+xoTp2i69pPMhjA0
	rIT3/vaKeX2n70yupCdbr1xXKmKtUZTndIbrOZJu/f4WI49CGG1C/XhSC4pLxf6H00kZe95sVL3
	me2QakYwqKKfvbUWv2lyBnUwhg7X7Bxh731KU0U4m3b0Jde8RrqKSe0PBtRiLBX8bH/j3et+f0z
	s+aKEzMcfX3UX6dKEhLbcNL/OQ3odWrpCBUpfkFujZEll9OD+HeTusUf1Ww=
X-Received: by 2002:a05:6000:2003:b0:439:c6d0:b0d5 with SMTP id
 ffacd0b85a97d-439da3514bdmr1100478f8f.15.1772771196764; Thu, 05 Mar 2026
 20:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com> <20260225-sleepable_tracepoints-v2-4-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-4-0330dafd650f@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:26:00 +0100
X-Gm-Features: AaiRm51kQJxsAUDZwMF0npVnJq7V-HrtDGX26HF_euT2EzJ_Iux-ZPKiYwcPBMA
Message-ID: <CAP01T74wLbQ4ah-GhxmX_h03k_XHbuSx8Wx2mQ53zgLEPJ5gcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Allow sleepable programs for
 BPF_TRACE_RAW_TP attach type
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 17:25, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_TRACE_RAW_TP to the set of tracing program attach types
> that can be loaded as sleepable in can_be_sleepable(). The actual
> enforcement that the target tracepoint supports sleepable execution
> (i.e., is faultable) is deferred to attach time, since the target
> tracepoint is not known at program load time.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
