Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80E35675A
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210174; cv=pass; b=g23zpRKZe3DHshGXABThN49s7uEn8sRPKpY6H4gwtcyE1tRdEQd01xS2qyqQI9H5kn1UqGGPjs+DklO6UmTRw6C/ZvPpOfOZ1vODcIaQwTBg+fMMq4oNJPoI9N5nyG1sIEagry5UKJvqJYmQATCu3H3yazAlqL6i4/sFrXBZfEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210174; c=relaxed/simple;
	bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/xa6AGhQKLRGR7xL9gAkJn7MMErmqug+tjF9DwQX2Zcj6hZiP4G1TJtUHeo//2O7xyPfUCrfV9y/N2jVFdZBya+VmKK9ojZ5XpWbgIVXEG+QhZATN2IwVrcvr3Gsp6E07TrwnE+i8Uv/8nX9i0Dn48LdzF8caYngxoH6Y7g9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cU8SJfXf; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cU8SJfXf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51788280e71so2429431cf.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 13:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210172; cv=none;
        d=google.com; s=arc-20240605;
        b=hbBllZ0+BIHgRaXF4SA+Sn2M09rN1OJwqZlYsfgIGFtOb0sHKO63hR1OZoI6R8QZok
         qLCum7Tjuf8PF2WitUlUuqHvpaVSoF0qcuzP7wQv0+YmXnO7BVQscDEC9C4/KcA4n6TM
         SwL7FExY2RlPsPCbZXLqA1VVOjRciElI5NTjeuM4AUphPXvJqfxUx9KP2He/Jx2MsXJz
         6qlMQ9xvsnu5Q0lI2oOmdkClujJz20td8G/0Ut7q6st/BRnTtMFk178NiSNEKCMTv188
         EUAcxxRTDAhmYyabWizWjNbvdaR9Cv8TzyJAn+aEc5ksTWKoQ242gqDHHe35IJZAkHN4
         UDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        fh=bmp9mHZo/n3nheutllsAjrE2QyskNrja4wLPYThdf4Y=;
        b=Dyr+MUY+mS/Wyn8XUfBy4MJYcDw3Khx1i9wp3UxwJKqtZcDxQiYTPeS/GQILCIOVao
         VCl3LoVeP2tytQ1QCEX+aLc+KEQE+kEay5o9Aw8A3uRyozH09VcKksrMq7cnKxRVhG2i
         QARn/3x6mclwj0GmqTA56a2qQKWmTXjbtis2v8k+7qGJl9vCRFY1UiSXyZnJ2TwYhm2X
         q4XX9yqkz7xEFs/H5qtrJEm9P18ylM2NyOvXEfKcj5/E/YFNXT4wFjP6ws+oqjuK7qFS
         QFljnQhFG5iELKa0nrOpAfx33JDPUXBJvH6WIylwcBpZyHyf/w5RKnKjmdMfS/IeMV+4
         5reQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210172; x=1781814972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        b=cU8SJfXfJXLzGHgJ/r34vTrLBnm8A2hpkqOAD/d1bDON1x/84AB48QWZT/4l77KzXI
         llkML2k7A9GO3Eglw+ExM1TRz6iNzgQcTj4fh7TLP+TEuPmJgpilWTVbOriUC2yfAN+T
         oR0fWZuh2X+HOEXmR4YSk+8D47G2vjgBNikmwCOXJ3wOC8M8fK3ymRPcgw8lZySYNzz7
         3AeE8fhn7Fiu31UJffpzefIN+GjOtDlrm7aEpZ0IakqGwjZ2hDDoJ4oLjm57INbfPkNb
         7onBV9LCgDdAsboILTe1ooJzdC8DCvOoAfB4Sz5HOFXyDFFBKnTU3WZhi2/qAbU+1N2/
         An8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210172; x=1781814972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        b=Nm1TRLVQ5f7kSwSkP8YWHOzOdo7zU8rodDrCK43P7LSvwiJtYIfnpD31EhM4aGgMY4
         HiXvXgkuT2cZXxCTwJMjoFogpDQgo0nfN9AEKjDCqdFvxE5RKPvvCQe6/IAG1t/ohUyE
         R1k/PBDE+9rGw3rhABUuUy1qKOm1MWSOLZIRjxHBHY1uKJcT/yV4cC2frj7ucbTRS2pf
         ihnBGpkDz9hL3hdFxH8fdHHXizkLTc5SPCwfYvhpjL11DAPnwcu67f56i8ASwghAUlCa
         4lxM668jUtKTPdBmp4H9jP2uf0WYLayxUphvqzCnif3AGOUCgN5OOTPLw8hhZd90Io0M
         hHbg==
X-Forwarded-Encrypted: i=1; AFNElJ8PhWErA/DT9oReECUOFPPE25/Sgby49gykMAQmnMq1kaZLyF3ytG06nhmxJpkMQ9KPuH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUcEIxlH2b58zImEpbKFbXeN7MK9itY/R1KHQuPNDNyM2zcnO
	4chSIxeWM83TG4C5mAVMGfFI2rAFBDi6tjRKtNZSsB0fHRVwhr4rFbTzWIa/YumTz6ju3Tzezlw
	fHoxd+6Ho0arC/Siago2+vaqY76Aq3WAC59aC3X5c
X-Gm-Gg: Acq92OHrEMnYuw49oQlFDQLT9hZnqVjbawV7g7tCCxi8q9mzzpiLgmG9t3ppx9XSQ3e
	sL0whfEeOOw+uRqAGogl7xXOarh0yvyP3dg0u3gzKBs8CPWQuMv6PQIKLQFl71HishGfwsnA271
	vJy6VnTWvI20A+CelrShLPwPbjY2nyuEmQ1oQEJh+oQfiVBVeF52vrcP+YCrTrptUE5uzwO7c3b
	uIXL3XjmdmvVPDVPicEcj61rQCuHmkrS3Mq5PHgP2fMG7E/QKoZ1I1jdKjguM2JzNJ5W4h6fQhG
	q0dVX/AkgVUlWAaKGcYiXPZXUavf6TcTIF/E4S1hzWEYv7hNDhqVK3dt6UVG8KuAxAXGWQ288dF
	aIfpQHKiyYLX0TRX5lJw=
X-Received: by 2002:ac8:5d12:0:b0:517:a174:f419 with SMTP id
 d75a77b69052e-517edd1bbc9mr69665221cf.19.1781210171888; Thu, 11 Jun 2026
 13:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
 <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com> <PAXPR07MB79847E7E64F4ECFA0FC3A612A31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB79847E7E64F4ECFA0FC3A612A31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 13:36:00 -0700
X-Gm-Features: AVVi8Cc1qElfZSwEp4ihq22L5tT5Xcq2RvWzms7w7c4PXXDizdUc9k1o8r1vTMc
Message-ID: <CANn89iJp3-EQaPcrFXs38t6yDO_p4BcSnsGR7FmOP6fRpoL8HA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Neal Cardwell <ncardwell@google.com>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:33=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>

> Hi Eric,
>
> Sure, in this case I will need to remove exisitng .min_tso_segs hooks and=
 replace them with new .tso_segs in the next version.
>

Please send a stand alone patch for this only, do not add it to a series.
