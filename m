Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792905887;
	b=KkeHR4t6C/nlVR1T9tqa71tx+5Y255b7id+rqOaXPPChT5HYJ2VwamM3H3zj8Ztnjbmm
	 oeaP8v56Zdr6RzNBtiNzLuqh8u9t7NNw/EqJJVsmyoTsB5a9WbZq0r/unqzAMmnZ7qxaD
	 Ae1OR8Y+rPOIeYjS8bbAhBP1iMNxHb5A/R6+hNhqZzGYDnD1cL/o+ySC3uLD5gAi1ebtn
	 wy0s5RDcooeCp0qUO2mUfhjcPLPxyLuoJCoGWBppkqgum3yN5aHExE88jdMLqhSp9Y1Yr
	 HPnsMeb8lpXitzUoxOILtuzbKo8tlYUBcO920gwQlxWEynuI7StFDksfo88gD4Jd2+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JmvqmuS3RCRgSY960jsRVEbpfVE9FxMYov5P7FF7wYA=;
	b=XzaWBrPKTuj8mY1XIF6T8Ah2D/8I4H5wcrHU+2Q8C5sDkKI6daEc9s6ivlyV97mRjLt1
	 DSImTmVuKEmU6DSC/llTlG3ADu8W3NOEe1MJm2Nc/P1xvcTanSixC0JBiNM9/H06kanRk
	 mLoKORlY3YC2ROVKDfRQ3i/CA7a7Ir1injqMLo/MRs3W6gF3d63j6cRk0I904uS4MQlcE
	 yutuvV7YvnyzOPuUo6ginpl8LnotRuStmKxgME4xYQOfvU5A0w1jM0ltOGYz2iU8AD10n
	 07wiDqzKf0vSPoIU0xwotsZ8xzxribOxL4ULVAcbNOJJLhgHcBUaUFctE5gyjLcIK+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="XD97Po/b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E7606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 05:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC7E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XD97Po/b
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso12792775ad.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792905886; cv=none;
        d=google.com; s=arc-20260327;
        b=AO/G6DFgtHxz+AsLy/PIlyDyRMmAwa9kVScj4J91O3j/BHapvLQdIL/8a5rb97LJfA
         mHM5pjKqIH+n383ivv77Q0ZlbvAjGxjK0lcmz3frg6ue2AkAnyIyiXN1QNirvljIE6fU
         hV/VDd+ctD3w/8fpK1bVohih4zS7xhZJxROfLIB9g+yHWBrnoVMFpnHd1TBDGgnHyG3N
         QwBLq5OEqNEeOf+9+B+EyoX46KM+a3E2zYW+b/4OhplQN07hoG7zKLNk8pJbfqCGbjcu
         Pcl+VljO2x5t/GDZCX0Cgk3t1E7mkFVFFnvGb9O1EBaR1sBj8LAD92xr1HWMQo36SyZI
         Ornw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JmvqmuS3RCRgSY960jsRVEbpfVE9FxMYov5P7FF7wYA=;
        fh=Mofsf32okvksuebGt9ZocbUw8bNHDNNLAzAXOxVFoO8=;
        b=UFr4FGLFrF/vpaso7xS1xO0oLVdR2pJfPoCegEfJgn+bBeK+vxMZEotWLQ2Y1qmDeU
         b4ZRRAatuWwd9pVccgHaePlNg3HSAIydgdIJrPPkHGEGxVCxUvzoedzSE3fXuSspSl8Z
         JYCOlAWjPpj/ypjvea5V7eQ19wwDtfoGRb/RUYoymLW1Vs4UZoyUWsE8pXUJSEyFx1XL
         B+mWLYFZii+Q7n4XPQgF4DlPw8pQfpXTI2O9j++f4aiFu+kVG3wVlehChkjnXNUwZCtP
         yjsiVWTPjygUrW+xfDGHrO9XMkm4yDoIlJGRm8WQDbAq58I1lKm7k63Z5/1k9iD0CLQC
         QZYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905886; x=1793510686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JmvqmuS3RCRgSY960jsRVEbpfVE9FxMYov5P7FF7wYA=;
        b=XD97Po/bsdn/g2XoNidnUFRJA217vmNABupyxVihkQ+H5Z6mH9BkDj1w0JIMDWI9YW
         Cotc6EblhC6WfhLvKl0LQ/AAzp3L9AAJ9PhB4o6A5I2WGjej2k3UhBB7JjHyhdmnPadM
         ku9/7m1dsoH6vDJY53V2eIdWvejjPDUD1lCh6sntVjvnVq/5dOYHSjCpOD/oR9qUMeh5
         2smrSV2/OUcC7e1KAP0S6szKp+MDLBv4ADAD/exL2GyNUpSvjQLT2M2pvX3+v5ssdZCb
         ycdOQ3Yp3PX9C7mnGiXVOQ7G2T3MHF/t95ayjdOLsDBlztJVpiIAzMj4ZNtUfhqkEjKa
         vVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905886; x=1793510686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmvqmuS3RCRgSY960jsRVEbpfVE9FxMYov5P7FF7wYA=;
        b=2F2HuvyWI8YtV5aQbKplGOZLHTB2khsrtK6+MQJgQiM+ts98b0/enJTgaiDOi4GgVC
         ihW0UJpSH5XRvaEWEOTkNt4iZGlne+DoMRY7r7Yysr1+3HvKbkb/4O/cz6NUs7nt+z1m
         mnqk4HoYBYZmUV0oo+xA0L1ectTj/bLHUk4H5sXZyY82UOlXxPnrBHcTDZT/R0vHBlXY
         RuC6v4m1DnpnEQNeiJimIWnly7JDmOMHYuaE+8AQLBGToewHmaZ51WLpMWYF3YT6Q7Xi
         w3fMMTLWqKzNx/We7RPp0O5oDJ2YmRVNyZIGYehLm1v8O5WDKquSbOXo0tnw7QDwB4oJ
         CgrQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+ryFfBASaWhQHpMxpvGbq80EeiJ/UjonzcoTuUHQeoaB8k7XB+lDLUxHpoUGvv9ApFmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/8EGyWMiqojZqSKGjpXCRt99nxiBIkB1Nw46cwGktp6BTM9tc
	MRjKXhdXhcgcExn0B5JxYjmMAix3l2gkwqjbbE5KDJjK8d9BGfwvSIIz1fxnxTChoBbzfPFTqmk
	d7kUJDng02TmfK1Ye2Ni8e/lP9S+ZJ77Dig==
X-Gm-Gg: AYBFou2EahY0aYMnxW9WW2HlNoCkvOekKff4a14hoqKPFZBuvG1lBAYCS55URpQbviv
	f4pXs2NFl5/AeUDblesTed/UKpUbz79mHyPeoseYK5D4BGI7P6j8XUUVRLWKo8+qx+w7g6Nqkba
	iMMkusl1g+pvpAI5IKYc0OIaJGnGpYSdDIENoTLqRBGJD3xP+ZhMzXs6nCjrUqRM7r9umETnZ0Y
	46cyhCguJbNq7DhDyLjCT6hINEnsUPewvTWvRxxI1KhCGAtv0HghV1W+R/SERFyB2V0dflDp6Xj
	CMnOO4bRovP3+2x2aBYYUowQsAZOF1XjyYlz+8T2sAnPYqmYjebUUNq+5obE0lcd2XEdadhp/OA
	rvyPBEuoN91mEnviuxDc9mJGeprv1GKTMTpx0O2gOZkwPMt1zAFWzKPVJWZg3kLF/LY/ZhZem9h
	pkFCvAm3fAmvCrfy677GOzRXQ1wD4HvcK+2d6/9iuBstAQ95IeDmAn2qY=
X-Received: by 2002:a05:6a21:200a:b0:3de:7854:8549 with SMTP id
 adf61e73a8af0-3e7bfa32cf0mr2230656637.22.1792905885861; Sat, 24 Oct 2026
 22:24:45 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <sashiko-outbox-182361@kernel.org> <20261023073359.642990-1-yangfeng59949@163.com>
In-Reply-To: <20261023073359.642990-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Oct 2026 22:24:34 -0700
X-Gm-Features: AclHuK8D9FBqPFBi3PBiJgDdszVKktCBL1MTcZWmWKw0faNK82LJi68mzP3chsU
Message-ID: <CAADnVQKUu+xTzLYOby49UGX8+CnenxTGhxL4_Cr2rJrUWao5nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix out-of-bounds btf->types write for
 split BTF
To: Feng Yang <yangfeng59949@163.com>
Cc: sashiko <sashiko-bot@kernel.org>, bpf <bpf@vger.kernel.org>, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:38=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> On Fri, 23 Oct 2026 06:46:07 +0000 sashiko-bot@kernel.org wroted:
>
> > [...]
> > Should btf_check_all_metas() check and propagate the error returned by
> > btf_add_type()?
>
> The previous patch at https://lore.kernel.org/all/20261022064727.747304-1=
-yangfeng59949@163.com/
> has fixed this issue.

Pls respin targeting bpf tree.
