Received: from mail-vs2-f26.google.com (mail-vs2-f26.google.com [74.125.227.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A44137B2
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185309; cv=pass; b=NsbBnxOj8nBoCTQJsxsjcuBjkRehc7FLgAHDgGDH9gbwb0YijWqljgcxOXSEgCQlV1rtD+937YiUo8kjDsh8IoRd8zFEZA4BMJxZ2+N4ayNPRCVA5Y7ei10uCmB0DG32AhrkxQzye2wuvD2QuU41yd7lNGmNcXH/nTLJgvSo9c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185309; c=relaxed/simple;
	bh=eTXt+YWRlRejCDOgioYTKQsqgUN/p/gA8amlQ8yNWKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqbnu8V2NIhHIY8tqbUhKM9YA4DplO7WicxL1nYntb5ROKqsohnNuuwpp7n+BWxYWJbuosEGdQtZPmJph4Y2VSvwdZaQ6nj5tg1uKT+jorQsvxm413lLI3LF8F+g0Q45Sba+cmODLqvgVp9YHahfAQXRoaeZLIzdWVTNOc/h1YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=pass smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b=XbqwyzBO; arc=pass smtp.client-ip=74.125.227.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b="XbqwyzBO"
Received: by mail-vs2-f26.google.com with SMTP id 71dfb90a1353d-5c67e529da9so488419e0c.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185307; cv=none;
        d=google.com; s=arc-20260327;
        b=OCUjfb9S5oHYVBOHPGc7X32YLw4rKByZEyer0Zazhlfw9+oUwYrPLedCYwFw2A1ITV
         kNErx/yNJbDg+aqHsTgo6ZPfPV+6jsmFgGQNGaTLMpk1NfAaPiMOpqF0atlh+S/2T1Co
         Ok01bqQN5EH5hnb40vMioCTTpqBspMsII3oWd+4l8Zi8s/Z3CQAnPxz93vQE3KfMLu+M
         t4e+dJ+PVdRFQpMGJoZ3DuetDo6gg2N74lQ07mZBNxIImcJ7Hvo1cJaLOBBxbRAPKdMm
         nXrKjpsQA4mykgw5OWF/IWFQgirbzuG5tmOOYzNhfm6XkiX9V1MLZOoah4aXSZ1mhkdz
         3K+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eTXt+YWRlRejCDOgioYTKQsqgUN/p/gA8amlQ8yNWKU=;
        fh=I0SF5uq/I9Zg6/6vPl0B+FT3I0EPr3NRHvp7LPVH5is=;
        b=EDm8tdkb/aIFP4m8TL9TYn8rDmFL21mjiAb8RMiZhjbmdl/hKbUt8EnppWs1W8ABT5
         5UdkVkr05CK+P1p9T9FVU66wqdUf4NQ2DrbXC+tgJYEN1cuW1XHYMrFSxJxOdP+BTNv9
         n11+PJjtysjG1+069kXezIe+xCtx9wLfSiPeLz1SKSKxcmum3QQY/nEPWVpyXZOV3UoQ
         F9Lxgjp9rp0w5K/Owg7yL5gziZRzvPKG7BIpTQUchGVu8NpfQLPJ279bjF07YIGc7Vtp
         2Vm8HEFNDKauCkh8+kIEFwS8KE/e3cfbECK92aJuHBrY7STFrN8S6Xkj6RUHgjc4fExA
         vAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks.com; s=google; t=1790185307; x=1790790107; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTXt+YWRlRejCDOgioYTKQsqgUN/p/gA8amlQ8yNWKU=;
        b=XbqwyzBO580wnwSqu1bce/6Bu7P0NuoV8UcknY8G8wgjWYDJzy8WJFPYKSAvR5WLNN
         SqrYwX/vHaHnCxWbP4Ex5w22EI8A0pyLqJQNBsZdFLomS9iqC5VCddJE/fPNmlZDNhDM
         +2Ue5+9yYvHCksv/eRB7xr59f+5m4qTTqDjfZOhvu9JVdCumdDupcdokUjLxYhBPjHS9
         XrDYAkaI+aAkaw0VYacR0l1a5k93WLyl79yINDtUn94ttjq78d/JhMcYe1OXsBpjYeAr
         sHZ1u89SuJ6QPi7YkRW3h/8fm2u5Ukrxs76FAr2lGNW4yWn5FW1Ll+zORPHUolQ3BJC9
         Abxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185307; x=1790790107;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eTXt+YWRlRejCDOgioYTKQsqgUN/p/gA8amlQ8yNWKU=;
        b=Z02gI0u0zEhJTfx1GJgh6a8tl9LCkADZoiU4vBdQzHFL2Sxnv6impXqiWTcWOshiMo
         BayaxQNr9WtFip7d/cxR12P97Sz4DD53mjn6kD41nYefPAEx2Qe7Gz4XaCXu9hJKGIj5
         AXF/sPhgxC7sQhgPQjDAh9J/6JN+v7xtYeO9XR25zUb020Rb+ndmfCkpkhnZWHeFB6ql
         gVSMdWOeMChQPY0yb1teF2YOk/Z/pF6OkqyyHKDvB4xldX2zwG2NxdLWklyLSQXsaMI4
         CpqRXGLKiYd9CzlYRwGWTXMq2UOA2RSO+yUkPpwBKV+A3FPy8mAjrJSjIP0QLV6mPm8d
         tW6g==
X-Forwarded-Encrypted: i=1; AKwUvBzzqND33iCJWkoqw7xiGy2gekdLqaoLYzf7LuWg4M+qnrWN36oy+8+TkOCEZylgkBw382g=@vger.kernel.org
X-Gm-Message-State: AFuF++lmf0FJgJU9pxTgA64H0TQ6agLj+QDB8pWPBjLiDTYLoxd/SzuV
	ZFic9vEsAoF5olKo1acAkFsNyK6qccXHR42jfL3DTo5WiMyMqYhb1sakYagR4XFHurXxC6ekzHU
	dflcNYkP+fdA54y5fTtrhfhtqcbKNvxunonWfGN8KLg==
X-Gm-Gg: AYBFou1VK/wIyCgkEsBxysEjNJYYhPh7XjNf7p050LQ5ySU72p77digAOa7+Ycr2rNr
	6Sg080DrXDnxBWHJjPeU0gcsElrjWOVqztG45ul6lu5HmM121dcWqbAH9haRkvMPM18+EPX3WTs
	xAWzycJT7TzFLl111RpFqaVpNY1oh1OEEo5ck9aOSPz1J9KPvDib1JRql3Ru3hfSQtZF/GuZHsg
	gpiKBdu7gvScAPWb//cKtTopTFwEODbPxy8SOVex3J3anMH0Y7M5wfPKUQUCF8K1Wxd8ZDBXHwL
	9qL+gZwX/kwrHqP3nQ9TFH+e4FBD805ztAS9CZmYSqDFQUP7UWfn0ywLVsD2L8Pc0w==
X-Received: by 2002:a05:6122:2207:b0:5c9:a60b:e5d6 with SMTP id
 71dfb90a1353d-5c9f167b9e1mr4151746e0c.16.1790185307262; Wed, 23 Sep 2026
 10:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912180643.1426488-1-main.kalliope@gmail.com>
In-Reply-To: <20260912180643.1426488-1-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Wed, 23 Sep 2026 19:41:36 +0200
X-Gm-Features: AclHuK_YVE_M0LMnByAXkUpK3TPaTMcOIBWbPB_vF5KvqXaURtUamsR22WrjU-Q
Message-ID: <CAM1=_QSGvyph2hUcf4xD0gkNeVN5vM-ragecigyy0dGpr3ZU_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, mips: Add BPF_MEMSX support to the JITs
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, paulburton@kernel.org, tsbogend@alpha.franken.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> An out-of-tree
> fixture strengthens the signed/unsigned load comparisons and adds negative
> and sign-clear loads with dst == src.

Consider adding this to the test_bpf suite.

Tested together with the other MIPS BPF JIT series and fixes. See
https://lore.kernel.org/bpf/CAM1=_QTjcyMtMLawSFnCt2c5wJJ-if40GSfo+o-CoZqcgx5wYQ@mail.gmail.com/
for test setup and results.

Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

Thanks,
Johan
