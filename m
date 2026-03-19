Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187C37268A
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910963; cv=pass; b=t39d+kjy88kGKs3uAB3d8c3AZX48d7XOGl/dwy1OD5TW2SLUfh3J7nDWV07yKDr/YvvsFCE9fT0fPfFuMEYSg80mP7AhcQ4DmpzTCyJ0Sw2x0uauyk7dlxTpxvv0dShZfWta3Zr4VPFayHGgs8BDhmf4uY5cZZd8bsOa1zl3MrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910963; c=relaxed/simple;
	bh=TIXB+xHcbufjB5Q6aRGyMOs0E4bJORdAbn3Vn2HA2wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQQ7ZhE02/wwlMa9sSizvDLOBOleMHJMUwZU9nuLQ9bs8HnbcKaDL8+cOi/Ank2qXNytyRx2u9HdtSpa7dps3hlhIvDsI9T+cOhq78EtC1HAjCXdfMj3QQ/gpE/okIU6TlC7BkeRSck8E0SbY5X70pntBesmMX1NQRoM3E85gzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9R9oJ9U; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9R9oJ9U"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6687c29d39fso225790a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773910959; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb2INiLRSOpwkvzcpGuRIEI9B0IXBC4z/MosyTSqoJETUPffotCMzPG1cL3oLiogLO
         x8SWBFYMK4kID9bJXImbTrIK1PU+fxMqHl/rLu8t4+cRp4iP3LeAROKfitGHEJlFGivp
         pIa6E0JcqTWjBMskAgRoDQXbg7bwFuw6Jq+9NUGG9Y3bqgAiuirjmFlZjrlAYCEk4uW+
         LSqA5CXt+K2qlbVRWy8nsvtYpqNV7hkWsSj6BkVPRVryyopXwqWx7Wdwb+8IY1u7wswp
         thApE0v793ex8JkHkfDvXasos0h8MW9QufxAWvZTqgk1RFKcaFxwZ/jB+O/x/eH1y/yN
         vbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TIXB+xHcbufjB5Q6aRGyMOs0E4bJORdAbn3Vn2HA2wM=;
        fh=LdIW5EYzfOG612DMnc6tLskYZ2znxMYohpYpmBQpvhk=;
        b=VKC8aWTMLedXU+OvCI0LvA0AF6R7pWi9ECHAObxUJ8hbA6CaWVnE5hfIVnsyifaunx
         xJCRdncng0b1ciJ5LYSBDRvVcQRIELOF/h7jXgJdcXyRgyiuIuzQ35RzS4sELXbuAQ73
         MJSQc5/C2LX9VQe7hXZz0ziu/0vvCmHndp2EXGZOEfDpgyr+2XkYZT8n9B1QlBV9d1qH
         0Q3MmNSXsWXhvQUguD8VOxNmMyG+5yuR9nFCasEXwgAmQL2aYEbe56oZWsC2hydItMyR
         mX+ZjJVxQ9OR/iAHEYTjvHGOsocTnFpBj3ZjqGzO/4DV0foPDUDkDBP5kTiDCO6Dbgbw
         BPEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773910959; x=1774515759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIXB+xHcbufjB5Q6aRGyMOs0E4bJORdAbn3Vn2HA2wM=;
        b=d9R9oJ9UeUay9ejYV2UboWmXnUIgBG9T4U4GGDCSAVCUD4dKm1tOSxPM42QxfI6WZ1
         HgcO1NFUFX4mvQd/JUhtmA8qVt4pDCz9+MEDDcIeuUcYw1q1Epsrwq2hf4EOhaazfgH1
         KtfupgqUxlzXg8nfaDRUgqpKhhmz4X91nodLoRjz2ViVT/FlwRRhL3RjT2yqETXyUZz2
         UvSth43f8Mf7at4hIT8B7ojZy5CvK/LNsyIBDAoU41lzo6kBenunXhsDkiAQ+vlxrevk
         G49WSxnJhYnAun5CA33XYEQJCFREAHY8HFoQBN7uZQ/LEMIshpJod8ig4q19VYrw5aQH
         LKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910959; x=1774515759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIXB+xHcbufjB5Q6aRGyMOs0E4bJORdAbn3Vn2HA2wM=;
        b=EIpzyPqvupjASSpIuNRYU1OvpumJKr/Y7s8RMzynVN/3Rr8JhldOI/uH3d9nG7A5mX
         pwMo+sA5y5+EY/KJwKIR+vXU2183f9f/uuzWwqCjzXTdjAoJym5CY5Q9QTzv9T5NLN0M
         6P9q6jUoES6L/hzPw6xh09U1WhFYCg1YBikSc/81VLff/vuWKN9yjyXFw11GSnzzdesi
         TXmIE5CTzv50RfmgBXd5W2ELz+pqB92AguPZjcFqLDIWRqugC7b7/sIHHofyDVCARino
         3O2IUERvl6uDMu8Rig6pTMDD8nhKHV3zBQ8jfie1rYpFUyofGnvb3Oqk1NfAaZoeU2By
         3Hqg==
X-Gm-Message-State: AOJu0YyvA8/NfvuqIdnCIjiZgrvh9s/72Ccn9sWFONVWnq+nWHPrRv74
	xmAvqZfDkP5NN6ZatA6i2wS4brzrqgVTzxWBLqFxFY2wT2/bCgyuVzo5lTn+qbeNHJXuqBboDKC
	XOEHyQFmGByeZevmWu4rNFOjwDq2z8A==
X-Gm-Gg: ATEYQzyKCtkYrNET3bmnmogeY0Dviqh/F6u6qahVcZb/Z9yYtALlQZ/umDOq3O/NstO
	7TJcL1SnarIxxYJjZ9lpv3ed/YRu/XaPopr65e33kJ6JYfYRuxIKrxfx847K3Qz1EbI9u2AfmAI
	AFUUr4ljf+S0mMyOs4KXX3/6pMhquWBtZc43xMFyug+1htBHhJ9CL9b8uu7W7Nj6OVMHnBXXvpP
	ZZ3afopLKsMB9lSodYXHeb0IIP499mVBnbZxb8O0R7f9uWAPKQN3EwGTSmKzN3l4LUnSQ1bQosb
	O39xub+t6QfCpY2VEGaI2u8P4w==
X-Received: by 2002:a05:6402:f16:b0:663:5d12:23e9 with SMTP id
 4fb4d7f45d1cf-667b38c8ac3mr3112955a12.26.1773910959051; Thu, 19 Mar 2026
 02:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch> <9a6dd99e31bae75da12eaa18ddc7424534d13621.camel@gmail.com>
In-Reply-To: <9a6dd99e31bae75da12eaa18ddc7424534d13621.camel@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 19 Mar 2026 10:02:27 +0100
X-Gm-Features: AaiRm52KQDulQVTc5Lt2RFJYYFuvSdx7m4P8k9cLivemyM5S5-kahlyasWk8Sbs
Message-ID: <CACkBjsaqSDfZXR4ZVUZaRfkHYKbgc4cGsnA77QwhHe6G7wBHsA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]
>
> I hacked a cbmc test in [1] and the checker says that the new function
> performs according to specification (and identically to old function).
>
> [1] https://github.com/eddyz87/tnum-step-verif/blob/master/main.c
>

Thanks, great to know this additional confirmation!

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
