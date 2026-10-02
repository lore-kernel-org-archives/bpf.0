Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CF38837C
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938263; cv=none; b=SssfFx+/v1S3x9gOHb9IBIsHO5OZe0uLPlYESE80V+ptwgH3e5tiyi7Hrgbt0QlIJa3ZPMVXlfTExhZh+dgAAVjAE/oOFg9+oaPnZ10TeLlSubBx8ueyZdosUBVV6crkq42SmTxyyePELiO6RUS14HAoO2n2aeBJOo/vE/70Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938263; c=relaxed/simple;
	bh=rfcOoOtlGTPz1TKiuJZ2mX02ckUj2nRA0WPW2VwXXvc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=etskB+hKXGE2VRBOoXtWlB5acPqI08cCah5wlifs6srQ4o/SSy7Wg/AOEozKBiBcFNccXtSygPMZy9JunppMDLqqcZE/EIzkTXXzZQMd2aicT+2qAmHjB///nB4JuuEwz/zSo3QfJsJ9+CbGm1G9t1y5eF0EVkhRw4T0j5uLN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mpnSpZvC; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mpnSpZvC"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso39948645e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938256; x=1791543056; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rfcOoOtlGTPz1TKiuJZ2mX02ckUj2nRA0WPW2VwXXvc=;
        b=mpnSpZvC3y9DXdrqbgqm5OjQWTZQI3r10PpVtn6pm3Si2suNtTys+t0Uo7bOzoZaoa
         LvKC5wExicn6pP5hYzJy4NJsT1vj5XQ1GQZA3v79Msc3YcYDNYCSU3UzyggnN0BNKOYa
         eeaxzyXlyFE8uJdjPoC11VeAdtbGFy97Ki1LIndUfMBF7k+kyNmlc5oXLwT8peboeRah
         Ak4doTZtcYsN6J3BivphXe+Uqn/A7RtS7a/MN/yrYpLXg9QgKZNRsDt8pG0dCVoPfNlW
         8BUoGKK1zmdbHk/xRyt0sckScur0ZzWyUsG6xQlsjtWyUk7twRMaVCQq3JUR0ewze1yz
         o+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938256; x=1791543056;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfcOoOtlGTPz1TKiuJZ2mX02ckUj2nRA0WPW2VwXXvc=;
        b=NBvXFj1i7/LRXKakjq2NtlLttDNJ0WOsXCbFKAunTsNKuVHYLWYizjsxjXW2J9vzxn
         Q7+BNJjESJTXVQXBrsjv+uA5z/E5KJtzUbirQEek7QSOQKIgb8f2x9LU0pftRgx2gX8s
         c754KIwiNyQP1NCihud5S+XPF6YFo0vXM4esgWDnMC8boHHujE7GhoSg8r7xZSY1K8Nl
         Zplp/B3uu9FNg97RkHNUUaHTjH7t/xcC9YKnyDYVItDIzxANJ3d3VOHqQ6zpsfWtYEHA
         nhTDa/bbu2PlzQBkM1p7HJD6UuyOPuMXnhVYo9pXBpt3TxwjDIe/TWgxGzHr3PRPR6Re
         FbVg==
X-Forwarded-Encrypted: i=1; AKwUvBy6b/yrPQ7W7g2A5i+AS7ksOrm2hXveBdHA3omEdLYSrRjA9U9Hi0RTEyM+dv7UE8lZRTA=@vger.kernel.org
X-Gm-Message-State: AFuF++me1XWy4QBFQzt1kbDcE77ELP82YN3rTZcqD17rEJg3rxCkFgHh
	a+XJM+Nav8VJYu6T3/fTaq7XIVmYXY7Kw2nw3G6qt4+LQOaEb81g3ljbnucrNUMZca4=
X-Gm-Gg: AYBFou3ba6HdrkV3x0dW/ACkYymK7Ot22KPEVuV4o8egGNN7Xa7x1vtSuZe2urieguL
	+oTA2aZxbOnr96nXiN4g4fcs4HL4rhZ/d8z5Y0rvsq9OzDsnDKV/QYu05DwHTvNiy3KQmU2oLzz
	N8opRiP4IMFPCXZ6stjM6Nh+Qk3wAXi+vMrlsz4qi8j0ZJ0Lr5fBIor3/KBdoTNVTE2zBstQ+xq
	MIj/DCMrzBFysrK16Se/F6PssHstofm8VSOiAuO/epJq7WeHGVjNbkPSAxjXpW8F694eeQ6YAER
	vhoYQix19b134gtXvoPm06JnyP5mCFGD1Zz3pPIqQncKHk4wNc9KKhfw8+ZyFa7tG9m2mupg8fL
	dID38fKC4lMyOpzyu1WZC5syUeAEl/776u/Xpz3v5h+NWWXSfmU25NTTSRFC0n5KJH1uqAKDaPX
	p7ZHdHearJJr0DYyqmw9uDdkSZcuMUTQgEY7LAIV/3sZUsmostJGg0Fsvk9c+WdzYxOg==
X-Received: by 2002:a05:600c:474c:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a02756efd4mr44533465e9.16.1790938255762;
        Fri, 02 Oct 2026 03:50:55 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm53874665e9.0.2026.10.02.03.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 03:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 10:50:54 +0000
Message-Id: <DLUAMK0HBR6Y.17REVZKKQNLVS@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 0/7] Make sleepable arena paths use
 sleepable alloc_pages
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <20260929183928.4896-1-emil@etsalapatis.com>
 <DLSJ81WE2HAS.28FPKEA7RBKAQ@gmail.com>
In-Reply-To: <DLSJ81WE2HAS.28FPKEA7RBKAQ@gmail.com>

On Wed Sep 30, 2026 at 9:09 AM UTC, Alexei Starovoitov wrote:
> On Tue, Sep 29, 2026 at 06:39 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> v5 -> v6 (https://lore.kernel.org/bpf/20260928202643.9114-1-emil@etsalap=
atis.com/)
>>
>> - Use verifier_bug_if() for diagnostics (bot)
>
> The WARN_ON_ONCE()-s are still there in patch 6.
> Sent the wrong branch?
>
> pw-bot: cr


Yes, my bad. Resending the actual v6.
