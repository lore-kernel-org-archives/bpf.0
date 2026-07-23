Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B8403B18
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843954; cv=pass; b=f4txg6ZHJSMOhipARMC9VygXKFEkiqI8e6eCsGq5Wshn0J49+00CApNegSItGBihKqik7R0Ali0Zzreq65JuoWn4ARUwK8AY7XfSNHWwv9e6FCZAjDWgYjBpWwOkyGNsOQ3pINR8irCLiIppLKTntfi+k2B/bt1Gl0xo50cBsYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843954; c=relaxed/simple;
	bh=gan9/PrdEHGAh7Sm88mxBdjeKycsGOhzpBIKfrZT/+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK3koDQiXM0URs+/0hfJFQpEpgvmw6LKopGn1zg7xRGgwGw22Ydfrn+skOE5ewRE+tEpYHqaBLNDqCDnjrVgj7I6nE4hUSblujB94NCAKQuDyS//913ruIuNX8KfLvsgeRMSQIEyAUuY/Ic6Eicyls/31I2qax/1ToLrMLKzHrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2EvZG9d; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2EvZG9d"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ecf499af9so10306747b3.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784843948; cv=none;
        d=google.com; s=arc-20260327;
        b=MCCLSpNh9PNBvHYoRdZ3XasNUCYyFiI2YsX9y3KChd/yvTwtf9sSZuvB47216/OC54
         ohjAfcUJKlt4ggyXsbc4XGFE73OyLRzTcV18W9xlUYOvdWZ27ZAy9ZITf57Abgv6cqcy
         VNFVshq1mfo3JGR5eCxREdVDDuknFP0255wiubrg8PTn8u+cxIAltZ3hwQg4qQsh/GdJ
         sE5/ek2ClE+fs0sOZyQiPHZIrFN2d0QzwzgsNJnAd7nP90TCOUGtWzZVyMzGl0ZvOU+Q
         lp/mJbglYb+H+dgTAUOTX9JIRiCTX0DBkXg5tqWx2SsatCTxXdBN4tFDaSLjcRmd0TwZ
         24HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gan9/PrdEHGAh7Sm88mxBdjeKycsGOhzpBIKfrZT/+8=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=YRqlwIBhr52dnN7SYF64KA+grpn8vG/AvQOGQAbOJMPApd7LIbsWufNyX7NpiHIz4/
         w9L7AFrklmCp1ibWXUEwCMQY8IsmTKRaQP3QP+U65moNbovmuDi8Wipd6pcrXQZ0tAXB
         8JwG6BRZii1VczoLZdAfW2cejmYc649mH6OmiePeBseBP8jfTkMz0iu12armnRRXqRLE
         rpYx7Veo9LF9qUiwNnV5S+3J9QXuP3mQCvZ1c6ZB1u5A4cQtRGRE9GAAqVg6vNaLBYx2
         j5uhZrPTeRFe3JzG5XCgC0pjOFrfHiY0OBFRpurtN4hB75AHa8s6SRdQkBS01f0WnS2y
         dJPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843948; x=1785448748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gan9/PrdEHGAh7Sm88mxBdjeKycsGOhzpBIKfrZT/+8=;
        b=Y2EvZG9d1poUcVv5+xfXX6Fg39MY9ubReIBwo3fz2QPIMS7CYVGiReNnwQg01M7xn0
         JvunUt/ap4/zAzEEW8gOjJfqCUw64GPBYbnbmkrlAqrsGsAEepid/B8DPKLnFo3rtjEJ
         BJIM/kQf8zBqGEitFZJDPuZcNELwQmMTimedLMoODV3K6EDpxK+MkV/5EZa9k94NvFQt
         AFASNER8GVtlgfIcl4AwbS8Ud3MY7e5xX7o0CEuDoPmeTEnXU6V8uJ1V2zYSKyp7ZKrA
         +17oDMzQ+Y1kfBeL3oXlOGgP5XKLk+ib8QjvC7d751nLTxpejbtt0e0AYu/T9z6znqZp
         OuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843948; x=1785448748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gan9/PrdEHGAh7Sm88mxBdjeKycsGOhzpBIKfrZT/+8=;
        b=sq0VFaMkM2Jwhd7gHXT44vUwKOYQRgjn1f4w49AEokDQkFzh3okhtREycqAG6+4w1Q
         MSRenJ6wrPMxQfjPqeVvI3BZI1UTlaFoN5pKT7QkSNUfV2LAasQm1dQhaiiVTO0p6Gm3
         +Nz6WDOo+MefgNxkQwXumQlF09CnWq00OLLJn5Z5/ldutbeTPVgVIL48wplqrxcd20Ub
         C3yp2zfi4wZyEHDTCaTsKd2+hHSUxv51DNrbZvomhAVjzfWl4c+n+oXeWcly8PwihvHe
         bvKtNLkhwBL+J/gTAPLj2m2TZey86z3I52LdSuYIZrVwZVLdyPt1tkRyGk4RLht6M8y6
         +DTw==
X-Gm-Message-State: AOJu0YzIDZOzQaxvLZ02pwjvbfsK2JMy6zoz6meboYOKmzWE+JASZOeD
	3AxYC+uuc95WGr8lipd5ma5YNb+tUYZqJTw5BkckxK4c/+efcK7124xupAQpjlkDSnVYn6H4dKg
	PX+IGOp2sfYHHt+VsQ1kOGHN4v6DAtLo=
X-Gm-Gg: AR+sD12jHn+WqwEO8mKpUSq369bAL2kiB56NGqAssGc3x01A/Xvo+wYYZCb1cUZhb1k
	3knc0hyhEY6Cp9MegSb4k1wFYFQzE7fMiOweIytoWhj/ljtf1hb/YGV3+WT8/6b3D9rmH9eOvHw
	ACHDbhgobNAcwda56XIJc/P8ASQwDg76ex9cDFfX4Xumi/wwSXEC5rpa7jlucWaW9h1kRkgi+iI
	7ODSaB/IAmMSdRlhb3ddl6PeoIvaJcW5a6KiKHz0PfomOIMtOVkrlRlsMFwcg==
X-Received: by 2002:a05:690c:4c0c:b0:81e:ba92:b255 with SMTP id
 00721157ae682-81f4c360141mr16039807b3.68.1784843948130; Thu, 23 Jul 2026
 14:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723202456.3754267-1-ameryhung@gmail.com> <e3fe822d1cb593c0ab78f20e2f16b2a832299ea3.camel@gmail.com>
In-Reply-To: <e3fe822d1cb593c0ab78f20e2f16b2a832299ea3.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 14:58:57 -0700
X-Gm-Features: AUfX_mzTACNaxnvIYkn_MUucWjDz8o3WvgzUMz84ZyM9MbJ0JsReWILg5YKrHCc
Message-ID: <CAMB2axO6j3QpvzQs8e3D1ejY1q+O6rS6rWsjHvFyx+mcVSUgNQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Reject passing scalar NULL to nonnull arg
 of a global subprog
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-07-23 at 13:24 -0700, Amery Hung wrote:
> > A global subprogram argument tagged __arg_nonnull is set up as a
> > non-nullable PTR_TO_MEM. However the verifier does not check against a
> > scalar NULL, leading to real NULL pointer dereference. Reject it as
> > well.
> >
> > Fixes: 94e1c70a3452 ("bpf: support 'arg:xxx' btf_decl_tag-based hints f=
or global subprog args")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Amery, git am complains about merge conflict when applying on top of
> the current bpf/master (`patch` can apply it with fuzz). Because of
> that CI did not trigger for this patch-set. Could you please rebase
> and resend?

Okay. I will send a v2 based on bpf/master. It was based on
bpf-next/master, which probably explains the conflict.
