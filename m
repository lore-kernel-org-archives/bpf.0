Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EE3672AB
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473033; cv=pass; b=sVHc958rGV5YH1b3iKGl1WY6XW/GY1nIKSQsSOoesQ7meHPjQsyqwTg9cR1yzyXH9ILDwH0Cp5Un4sRaYwcUr/l+JtZD7bBFj7/oDZY5+u6WWZpRAPzFyHffzb9etTJvBwOP0FvIsZXJXtKlNHPop0xlJmhc+INjpxUxOVxSJnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473033; c=relaxed/simple;
	bh=JIJpSwXNnBPrcXn63IdG3HPuN1HaHvWzjx+csgK2r9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAX8oCbvwdXVD9dYbsE5Z9YWK//t6EOMGtL8mObrhkRr0QWS8nUf5A0ge+y4cgtmspqYETEYVCSIENAlpfYUlQJUuSqeheQFPH2mj2eGk7Xff/sIqXnn/EtEvk0U7A2SRtcTXUjCEdjaAHEf0vZn+9jDsjvXFi4Y2GX64nkUsNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIGuTlAq; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIGuTlAq"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65e39d1dd38so7200073d50.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779473030; cv=none;
        d=google.com; s=arc-20240605;
        b=ZEuv31szAlNdt/yXn7/qRwxhd0xBBxKqLbMm8b9X3i8/LxxWAtqPEEXRp8XDPgOKyU
         uNwm7qnW89x/xiy1m8prkfq3T9W83X/6nOWKijuCftRdJePXNMKUOrwakmzRR100tf23
         X03Aef41t275nJgXkIDhupg4SQXFX+cWRQZ0ZXZcGgmaG4GWx428W+PeOZh7P8QKuhGH
         NPHQOSqOKc7EIIfQQlU9eJXdEZwiDYpt3F5Batdh9A+L2Ilq5oOF4rcgKU/7xXOrW49I
         Fk1/QcRUKXS3kDem6CNVtN/dD0Y+9zJ57CU8DM4O9bcEaCKYrHxTz0wdsX9Esa4g4ZZ1
         bLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAvKoLofKsQGqZymR1AGfu6iJTdxGQ2qnrrGg59eyPM=;
        fh=lVsfgDP/U1yA8WkVYwF7PIPc76UhQeHn0m5Dq1U1Bf8=;
        b=cVOPXjUuvs0uiR7USFEAgSPvCNDFUUfwmAvBgWYIl35eDGxFbxhD+fyeXdVUd21/4C
         +8EoX++O8sWo1ammgp1yjziWUwJP0uQSNGSdyh15W4tmU6hnGPn7UJOLG4/OyxUDuFYB
         YiIBxLxW1yqG78kNt9SXXe4m+6scSQ1EMhF55EI1W0gxwlu1v5xUc+LAQ5p+bZ1FAN3x
         ICUdzckUO8Xx3iL1sRtGrXmXNi34xZtJFjBvN2u3Ie8eRD6yXJMwFb3j1t1B9gXr90yv
         U6esUpd8sYETRQu8AnX0+D8HpqpHKfpKTSx+N83Na4a/A5w3x4V4oHJIH7OtI9mLkUXh
         +2kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779473030; x=1780077830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAvKoLofKsQGqZymR1AGfu6iJTdxGQ2qnrrGg59eyPM=;
        b=HIGuTlAqc8bBf0vYlyJ8A1otMctigsKGZzaIOzfz/h2lXhKPVHm0nWPxWZxUGVfIaH
         XXGhv2IqBNSG2nQ2V8KMIFGDhzFgfdoPgRQR2xsCFrwKQJSbSifCzguh+18f6tKQLL7q
         4FaqlMEgiE7Kx9ilNPazOegS9FAQTav5w8fLTL0v1Y2lzPX3BaRjuaiIi4yYoxFrnuBF
         sPW6rpCYeErx3NOa/5xDo+kfoEPiLs9Jka5RzfwQJ6S1gTDBjbwpjVj8ecjDfLhYH9wq
         zbu/CiI8InViiCdhWexRtfpFWEksmo/9DwcZ0Z+20KxQa2W2lgMyB8Z7VS/CHjWauzKI
         9Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779473030; x=1780077830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAvKoLofKsQGqZymR1AGfu6iJTdxGQ2qnrrGg59eyPM=;
        b=NWQKULCjoeXWatHud0oR1Av8bPWcDEZrjCEW/jRAHo1Z5m7Dd333YtnNMA+Jq+quT1
         WAXI1lpPRvG3OX0Jp/3aS6Cm2ngfVtWgyZoNkzZ+7sHYkKlt8qGVO7nz1+O/5V+Io/Ka
         ylgojQqKU5UMie2//bfDS/n0ciFhsUNR0mXXLHSNDTR+VDRaAKl8wIsOal3cMDqWzyv3
         wApMVR2tr94Q03ei3vxvcqwG/B6klvtMyHaTXINuvWCj5gYiIolreRRqQHO79EZ03c1u
         IjLWvhQr8PbvS2h7d6C1oOWakAc6A/SdIRqZ06m1VESKcVb595gO3W2bMjCzVWXTC0IN
         BWUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AnzS/nOvx5sVRlcCTueDuQacUU10cPsUc3v6NNPoUL92wtUxCbJhF+8ETNYkb9nhgXzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqQY2M0GPSyAYmBYUpFVxyF+te1AfFjbp1oDpBNuwRXX2hA/8
	AYrSF400XXXqr7FlORH/WN7eF++Jh4QUytsjxBq9yL7FjxP+XSWkUfNQxbpl6ffO7p7bk+3ENzh
	lAKmpsdJJouMa8zqsbIqCGRpTZc+sSqo=
X-Gm-Gg: Acq92OF7LpjmvF5v30mXznVUS7XasyiUb9C+vz6hjuTqukFXQdmS+YgevedbTb0bBHj
	ptrMQNqvMQwyCHtTakHyS1lzM1hyNWKCyrbSNOFj2Y9PNmg+4Z49dVc1PELTcaTOyDZ3segHcVp
	5D75R0Nevz4+x5hpsDXKGA0BBejKca/vJ5E6nbpjgYvdSGl9tFgoVEEbGryL6njqo3NYhopHYd1
	zuQXiMqmhbllYdc0bJVwJP1QVzu8vI7XOp1YhB0hsSVJvmFPDkFDIkFDl+Ug2CD3T6rzmviqOaq
	xrIX2IZjJ4TTpqJcO10TfmXIfCon77m0blHmh2ssmd3Il3Z4SF72B3JuCA==
X-Received: by 2002:a05:690e:4802:b0:654:acd4:9c10 with SMTP id
 956f58d0204a3-65ec96129ecmr3252205d50.13.1779473029966; Fri, 22 May 2026
 11:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522125657.328840-1-michael.bommarito@gmail.com> <DIPEFQQTYWPL.2PQYHGMN8D55U@etsalapatis.com>
In-Reply-To: <DIPEFQQTYWPL.2PQYHGMN8D55U@etsalapatis.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 22 May 2026 14:03:38 -0400
X-Gm-Features: AVHnY4KzECus9pqq8_cjJ0SAtZfo913Zbr6XCKh_8a-1fgz6K1kZ60dWN0lWRKw
Message-ID: <CAJJ9bXypexAppp2qR-chPb9ykxFZJASD_XM5oMdqEYKbdnmOAQ@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: harden parse_vma_segs() path parsing
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:58=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
> Minor nit in case this gets respun: Can you mention that the n >=3D int(s=
izeof(line)) check also
> takes care of making sure the libbpf_strlcpy below doesn't overflow path?

Sure, will make a note.

> It would be nice if we could somehow not hardcode the lengths to make it =
clear,
> where we're deriving the values from, but unless I'm missing something th=
ere
> the only way would be to snprintf the format string every single time whi=
ch would
> be overkill.

My first draft patch (Claude's, really) did that but it had an ugly
inner loop and like you said, possibly introduced more ways to make a
mistake.  I think there is a real pedantic version that could be
written more elegantly with helper macros/functions that could be
shared across other sites, but maybe that belongs in a separate follow
up.

Thanks,
Mike
