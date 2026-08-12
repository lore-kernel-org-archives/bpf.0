Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD11335081
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557209; cv=pass; b=Ag6QYbsV2hGHO+0QFMk6knGIn0pEe7T7pYzVOgtCKHtoHqEys2LER6trojyRicAz0f/ahNZQ56sYPINDFodH7zuLT05tEohArl6IRxB65AeRcYpvo0WNjTJ6AjWo/4QKLzo65Ngc3IjMkujp2MFOvQhCMXkvcq4E5O7iWm5KW4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557209; c=relaxed/simple;
	bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJONLNy19ONdNQ6OtodPNkrHYk7+QAFMdlYvDsH2zCxIQIP8rFV9S8Z5ITIexZKsyKzZTfIJRuVF+wdge8TCnlxea9qtEGfw1gVbdcUMxzJ2OkNZPwN7eNZO2xrZFrVWHJNorMi8W1jdIHhbOS7afTvH9awm7tH4bW75uopWoII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EYIwgLlU; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EYIwgLlU"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66b13ee8801so1740205d50.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786557207; cv=none;
        d=google.com; s=arc-20260327;
        b=nIgcQuBtYaOqZMMjYfrDZhzCdVWa4oPTXxvrl0bsnbW7svyHOjDvaAzdZnAWaGUcmw
         CADnkvI5G1tSzopxCMvz0vEMFR27Y5xZqIPpTPSWUtcoZa3Qh1kMlgqflyJA/VMryOKx
         5CRaQxtU3RIOfWFpGCZdGdITMQ0XqEWeDVE7hKmLEQZ9yKTp3FrfHqiFhd5CQqFd0jRN
         8xJGDFTwCkGGtDukcH4FvZQcoRpdJ1PRhWKcZsA402KI0cIVpvlxduTf4oT0hFdyQdTl
         EjSPBR8at9BVsaqaTMsIBJkueZbZO9U4sL0Ic5gM9JRFTRRVrxRrCClhO1GLdOcQI7zY
         hipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        fh=KAcIq0uL+NDzTLxmUIO/P/Li2Kp69cY1hM6+c3pDBqY=;
        b=YbcrBNJwjlAJMuyXraMjoWiqq2k0qHQ/gsnTw0N/5xtZ5g3wSF588C/Gx5wORHNlPC
         GTsFJlfKOwbOFc28Vi0ToHKMcPwjwyKWvvcKhcGYyClU09Cs/i+a66DYMqTU6DLx6NOZ
         LkrjwU4un5+dnXkcGxwHmYd903v8reAdbNBMOK5UBEBj7mvomgplI4OwnC2lOXrwcACe
         HeiZZhaSpMZ3znjGl9SerYgxffTAtTE7IGsUjNzmh0vXYQkfNhu3q2NjOmOOEf2QrnV0
         C/RApEhiqlUQZSrCDUENjymmjuZCgUIN2JA0s2JLACcxTbR10uUSLcps3zi6R8Hfm6L3
         04JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786557207; x=1787162007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        b=EYIwgLlUScfuE8SeO8qqwvk4aO1mt1gha0eL+fQdnw0D7VRT9gZsgNT4SG/b5LzTw3
         3Ko7cjxTt0FXc++YNf2EiHquf12KduVMr+utSOgzd3IcSRVMV9MMCNoQ99uASH7sWYJw
         /198/nD9VaYKmb7KbcQ/OQqtGEMqKIhfWfu4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557207; x=1787162007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        b=JBTm0MwBJMJx9qRr+nbD3xcgOWrLfYvPEoh+qwF5orYBUw2nVsowy25TCaVsL/tW8C
         E8fFJWiPX/H5FkPBTU4856T+T9rFAKCt+Lnjmezxl9vqZpOmMYpYbB0XXiLx1yvuTl9Q
         bN7jnUidNC4oNSdnNwJ5BwXnvcd1IoLFEOt7LFHVFTt4tQnF8V/G6hbEjTEtnv9bm0ub
         eGHc5/axT1IhsUhOV2Kehy8Ry88AvXq/+NIUUA3bBUGvH2mN9lA8c84A0sABsb0sJWT0
         az8ojy8VL4yhV8G8h/3PLuIOv242y62VnNEhFO+d0a2gO7+FRgxr+XPOR7TmEyIJF97S
         qW4A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0TzW96bDFeVgfkEmRTgq2HGTVF0SWs2PJUihEsG2teKcaqpoyDzZbVsflKJbT6mXRGgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/gamE8/MAiZ3gY8hiqpJPTEmIf4Ib4cYPZ3W9VRnn5I09PJL
	VwwvaLKO3k2Jc6ljimZIur9YTjehmPNaa44L2D+CBB+J6klzAbF/AtHnnHMSLeqIaYfgBHsQYzh
	pG4IDa5AcAKMEWO2o+5pAXOu72rYPl92rhg57JxZP7ZjZifGVpIQ=
X-Gm-Gg: AR+sD10RfywKAJieFgx9HfWxVbWpKErxofTlvP74yDAx9Qn5CLPFDd6Jp3i03FLIvN0
	RoJ4Wc/FIsYZZEliAnzA7Pyc+XGv7Ck4tzZXTMPlNrefrv/vVQE65UnR1xF7/6u0URcgaT9T8PO
	RgAAKoVmHM8O+uOm5L4/KjB/4bPLn4hJgRGyE8VTtEUAeOcEi5S2pR3BxrTth9Ok82G6avSiBut
	P87eT6loNJBu4aLJh4IYWL6sPaGi3vxIR3Jo12EYRnW//BRyJndzeN4DrMNtn2xExXb7MxzEsnb
	FopIMHORVIjvpQ3qgZb186RJFhl7hxq1B9/Q9vNX3mod+4D6GtGfR9Zq1Bs=
X-Received: by 2002:a53:cc02:0:b0:668:430b:46ac with SMTP id
 956f58d0204a3-66c517bf264mr25853d50.52.1786557207166; Wed, 12 Aug 2026
 10:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810164357.1653956-1-victor@mojatatu.com> <20260811181958.04b42aba@kernel.org>
In-Reply-To: <20260811181958.04b42aba@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 12 Aug 2026 14:53:15 -0300
X-Gm-Features: AUfX_mwlzhtn8BGL44tzbN6geInWjxc0TGROu9YogSdMc8FACCrUgSyvrqbEG7E
Message-ID: <CA+NMeC8cG60HaEFhz1AvbWi+xNYDE3pPwxqk9oTFBwf-mJQDPg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: add get_fill_size callbacks for actions
 missing them
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, daniel@iogearbox.net, 
	john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, horms@kernel.org, 
	vega@nebusec.ai, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 10 Aug 2026 13:43:57 -0300 Victor Nogueira wrote:
> > When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
> > listener) creates several actions, tcf_add_notify_msg() allocates the
> > echo skb from this underestimated size. act_bpf is the clearest case:
> > TCA_ACT_BPF_OPS alone reaches 32KB per action (BPF_MAXINSNS), so two
> > actions are enough to overrun the allocation. act_pedit overruns with
> > 32 actions of four munge keys each,
>
> "overruns" makes it sounds like we overflow a buffer.

Fair enough, it doesn't actually overflow a buffer.
I can change that.

> AFAICT we'd at worse hit a WARN somewhere due to EMSGSIZE?

The issue is more subtle.
The kernel might create the actions, but fail to notify userspace
because the notification message is too large for the allocated skb.
So it's not a crash or a WARN, but rather a correctness issue.

> > act_police with 32 policers once the
> > optional rate/peakrate/result/avrate attributes are present, and
> > act_tunnel_key with a single action carrying a maximum-sized geneve
> > option blob, whose 63 class/type/data attribute triplets expand to abou=
t
> > 1.2KB. tca_get_fill() then fails and the request returns -EINVAL, but
> > tcf_action_init() has already committed the actions via
> > tcf_idr_insert_many(), so they stay installed even though userspace is
> > told the request failed.
>
> Please TAL at Clashiko review.

Yes, I belive it's correct - the code should acquire the lock in act_bpf.
Also yes, the GET path suffers from the same issue, I can send a fix
for it as a follow up.

cheers,
Victor
