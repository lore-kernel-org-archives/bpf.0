Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A633F8A6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136917; cv=none; b=AoNcNYKxqpbJoZ3EWNPBH2ZpPdY9waNIzAbT9Nvv8CA2nzurQWm0pD7ppRCVF0uE91xaPrOSBCMVAUnGBhFLXXec/xHNhXJHz15VWvgcMWesrhpFG2PS+lCiYaF9KRYxK37yvjyEQwx02W7gOGeCFTsudyPaSNY+6Ms+/t6pC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136917; c=relaxed/simple;
	bh=EmtjjFbvf9N6mnSLk6CU9IL+h0+QvyYJcJKARdjj4+Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=E8GPCxFZdqQWDDERSRwKw+FlV1HoMe4WILCmVj1j3zIDth83b6Ad5TKn0DE6qzxSj4AxkBCsNM2rhAeGcpj+Y0o6tuLuTfandUT6nAk87mpacaUiQlC10DKxedyQZz//FW4nNUiZrLoOLciio/0WYstMmXTjWqgZ6E0Nte1R7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJo4+2Gf; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJo4+2Gf"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so303125a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790136915; x=1790741715; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MPdKPSEqjmHlLSl7qHM1sfV3taojEaErQs6q44g369Y=;
        b=LJo4+2Gf9yH6rkAupnybytJNd22h+wCrfvnN3+blvKUn8p6zglPB1rH6c4QTAbBuc1
         GHpyCpNZaDIK6Dd5xrJbhbvsls6lH5ADtvEXBE9AdcG7rz1SO86muNdVXRvAeo8XOSjl
         4Oo4KvlYCQxWKL8e66selY90VhlHhxYEfoJAS1+61xj04YLZHmdsT1882UhKWtnhc1Ff
         sQWsW6w03jtMQxdpt9Y/gMgBFg6WgjFRGL1/uwiSPt/uE84EdXZgS/2D5JsMAR+OyjBf
         mS9jMPJ+pI8EDX//u+Wp1lECyy652xSqZVROiXJM1Mbud53cSMTxS7NAEgpwrZiku/Gh
         4jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136915; x=1790741715;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPdKPSEqjmHlLSl7qHM1sfV3taojEaErQs6q44g369Y=;
        b=RDI/tYO28K63s8HYy0ObdoKANHEnIdEF5MAs3G3QFPQDEqCiZIz9ZCiegQPhW21PZr
         8YFhklTNdu77UP3ePDiA2B8Sk/k57RN7yvvvgJX44m2PZe6eHbz/ycJEPPP9ddAG6XS/
         wGePObinqWmwOznTG4sl8KEzQpyxhwWxBWXY2JovhPdKQOqrKJx66WrXh5y4hHYTqImn
         HPc4K07PuzSGITEWDqspik91HNJlNNZbT6gGycu5woYVEVxm527tPB2zXTsl5C/fHG/O
         wYdDQMczsFV+lwTgeh0w0wJ4Jpyh4QGlAc4vlUt331dS46vETriNIq1oBrhFO9Tlbw+L
         JneQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6V9NCuExd78wcdnmmSJP/IbWx8hKJ28TEgsBxkd3UylqR/laEzPwsDrJ8oaMCZxtltFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kwUPBnnA2RqRQThQWzwUABeMzpbdPRKHOwa1f2m1N8cbJLw9Of
	hnxP5fJvBZFhWz82Mr6iL/jeapHIipjvsMbaP63UDxrMQOpYcTCLzHn+LxVpsg==
X-Gm-Gg: AYBFou2bd/rxd36hwWUiF+Eap3TqOsBDifWllT2O+/dVZlM4avLA9qyuK02gDRrLJHV
	5MaZwPoWM1NdUHaCVGIP8wytKu97LhlHfu0WB5EBigW9CBrIVPJDN93EYCzr2QZiG6usGCDGDbs
	F9RiqJut59rl0plB769QIbZIZmO1nDjSB0N46RUX8RVtewOrAFsyHn4CGb7FArGvYM7Y7/6ka+Q
	A8vnWEvrhMAqojxY7wLGDhP3cVygk+ylJxnTVQtGEx/dAeMrWJJ+W/XOeMEJ4vzRYnZtveTQSsZ
	ZIFFl8Xy/fsjuMcEfbmlElPzsWjjtXq9BvP4IJO36WtyTXvGsuEBYV1ug8aEFJhS4lEQ2WRi9kE
	bi7spWAHLRk8m2jGCnMgBQB+Lj1/uHhEjNXQmdxc7HoROy/nGPU4QjMed5pB12JdYPFCtMbXres
	8pEjsJHHV0ur6yz8Uble9j/6XAjhXXZHA4qDGTGD9YIy8S6xKQ1tzyT1gW8jDbgyP9adxnwkxwQ
	5Pmt+PXKBtLBmQedxDgF7Iprp9sE7Gs1LCHwu8kG9Idr6X2GFwaBAWVAGlKYBTFaGjSUKTTbGIz
	qT8=
X-Received: by 2002:a17:90b:2b4c:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-3a07e4f7b61mr1235002a91.2.1790136914637;
        Tue, 22 Sep 2026 21:15:14 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddaf4f5sm2469860a91.4.2026.09.22.21.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 04:15:13 +0000
Message-Id: <DLMEKP1LHU07.31JTP12GKADU8@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
 <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com> <20260923041124.GB42709@sol>
In-Reply-To: <20260923041124.GB42709@sol>

On Wed Sep 23, 2026 at 4:11 AM UTC, Eric Biggers wrote:
> On Wed, Sep 23, 2026 at 04:02:22AM +0000, Alexei Starovoitov wrote:
>> On Wed Sep 23, 2026 at 3:37 AM UTC, sashiko-bot wrote:
>> > Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
>> > - [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are mod=
ules
>> > --
>> >
>> > commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
>> > Author: Eric Biggers <ebiggers@kernel.org>
>> >
>> > bpf: crypto: Use AES-CBC and AES-ECB libraries
>> >
>> > This commit reimplements BPF crypto using the AES-CBC and AES-ECB libr=
ary
>> > APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig op=
tion
>> > to conditionally compile crypto.c based on the new AES library depende=
ncies.
>> >
>> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> >> index d7d25477ef481..a44ecfa3e9ef5 100644
>> >> --- a/kernel/bpf/Kconfig
>> >> +++ b/kernel/bpf/Kconfig
>> >> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
>> >> =20
>> >>  	  If you are unsure how to answer this question, answer Y.
>> >> =20
>> >> +config BPF_CRYPTO
>> >> +	def_bool y
>> >> +	depends on BPF_SYSCALL
>> >> +	depends on CRYPTO_LIB_AES_CBC
>> >> +	depends on CRYPTO_LIB_AES_ECB
>> >
>> > [Severity: High]
>> > Does this dependency logic silently disable BPF_CRYPTO if the AES libr=
aries
>> > are built as modules?
>> >
>> > BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LIB_A=
ES_CBC
>> > and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig rule=
s, when
>> > a bool depends on a tristate that evaluates to m, the dependency evalu=
ates
>> > to m, which downgrades the bool to n.
>> >
>> > Consequently, kernel/bpf/crypto.c might not be compiled, and the crypt=
o
>> > kfuncs could be silently stripped from the kernel. Existing BPF progra=
ms
>> > using crypto kfuncs will fail to load with "unknown kfunc". Because th=
e AES
>> > library symbols lack user prompts, users cannot manually fix this by
>> > explicitly setting them to =3Dy in menuconfig.
>>=20
>> The bot is correct. Looks like a regression.
>
> Users can enable the libraries indirectly by setting
> CONFIG_CRYPTO_AES=3Dy, CONFIG_CRYPTO_ECB=3Dy, and CONFIG_CRYPTO_CBC=3Dy i=
n
> their kconfig, as the self-tests config does.
>
> I do not know what you expect.  The libraries themselves do not contain
> independent functionality (besides functions that other things in the
> kernel can call) and thus are hidden symbols themselves, as per the
> usual convention in the kernel.
>
> As I said on v1, if you want a prompt for BPF_CRYPTO, I can add that.  I
> can't find any other example of kfuncs having prompts, though.

No. prompt is not necessary.
My question is why disable BPF_CRYPTO when these are modules?

