Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0B31E106
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006779; cv=pass; b=HJMaROj/i7n3Ajhc8PM4hqjdIf/W84aQJFpGqKwhwG2LMLZQmR2JbaGHLAsTyI/+0pOJKnyHt+zbaiBE4Ji3hh7HlkXmTy8PDgsMwvHhdv2koEhV0c44beuUEGv+23ksOMd0nnfypUvhp5kCi/Kl8ZGD3OdZ0AwbrNeNViY0jiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006779; c=relaxed/simple;
	bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oub8IopnR9ATaP1AIjLtlfGgWXkSraXkr4hfb+c50UKdZGGDgjk7Sl6wdG8VhDuM84SSbiv4Aze8qFxx68iBq9q+7tNMTqJH6wU3eiMbsQKIZQec4B2wnIAr+JhAExTC5opTms2zqFICKTaPRmFOtiU59DVOigpomD1Ejakndg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d28bk7Ss; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d28bk7Ss"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a4e3e611so8263811cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:46:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006777; cv=none;
        d=google.com; s=arc-20240605;
        b=JOQLRUrAmVoRz7080kWuZjsHVP6fVe02reh2rd4MOmC1AIj1px2Kjk5l1aPUYDqoD4
         8sTWVQGVGJfkECZSdIHkqyNFsN77GDqljPT0D/9uWnyZ8vwyTtlg/n7Gvtz8AuGi6SqD
         77/5RD8HvaOS6BCtWXU9T4B975fHk6K4HB7Tt5w4iTsso+PMGs/6sxvdrbGEIlQFDn/6
         frrgIQeL+VEF9gnmMmHN+DVcyLmq6FHhvoi0y1u3tbtYEc26/IeBL8uUUkTcJ9YZZRFp
         H0D64qe9FGe9FcUFp3tusFfW9Z039QyC7zEyKony74lowWnoQrey+vpW/CWWGXKqciHf
         adJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        fh=FfC1zvfPb3JQ7gy2ECnUovg72mBRl2l3djnEyp9dpHc=;
        b=S67TUVHTseTzE3xNoXc0n1pwTf87Bs1tGcmtuI7qA4g/BkLmu5vE1qA5lwPdOpSY50
         7x+xH+JuD8mpmeTtux9QxZ/z1G/SaxrGUvCWF4N4SiuyGcBQjgSmhKeV+7lKmUenjeev
         ooIuu/rN3o++bI735CMyzBP7h75wITefwZeB8xT44c3j1XihOdzuZ2rd1qEznDTLcQAu
         qhXWk3PeQagxchWHjsvqVdAyDDdKen5gykd/Z+kcKHNm6fUyhQAjpckLHjVjsTnEEM2i
         7r1TwQkcagR3NiJWxr168npv/LkYkWoJ2GKTyp1Xugn9KKchQljhPs7TjuC2au8HBxR/
         7w3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006777; x=1769611577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        b=d28bk7SslA/sFce7HOZK4TTDYBBQeo+OKAEYlM0vlhVpL65gsBLhCO6KPHMsWlw8Wk
         mosONMTxIPvFSicjHS9iTtQM4OuXCGSSByMIwvfm/jqbC1xRIweRK0J9DZZDDVZc7KOi
         EmcVdXOBxQD8DhtHknYdgtk9PMM+uk9lBU2xqL/xI0JVgR5ps/6oOTaoGf7VNMllYt+j
         O1xWMrpwCI2RrozBPlabGr/c3iw/PgxYCxQCpooAepiS/GQ1d4WfMn6pbMfVgsRNLVTV
         A4swtaueVj0Qi9NeCwr5GoGrM1LvcAoPI4J/2ZlREuJxFyXsDmEhmdKgH7eXfQE6oemV
         sd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006777; x=1769611577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        b=wPgpno3NgG83LDjLaR/c1cLkZRYmS8FVucQHxN+AEkk+SQMjm9sACW1BSVoZRpWDKQ
         +zN8LsuzNEQjfD6jmw9ciaiC7lo7gWT9KSfujuLyPtQgZXEcnbYXNePd4PBs72Lehfcy
         T2xR0nmV8308Dhz31dvVnDkBx6lCVUAdd7RwVcH95Pie4bYiJ1dL5kC8NTwvQVBf+luO
         7pq49OdmSqEIh4/yzvUZwg9UxE+IyIW+BevkgmFQqohpTuMO00SOtUhi4R0dnytqcOVU
         jKWGsBo1IM+EPJtH2Svnzj/CgUtchDnrISYKN/BaONlahn80DVF2YrdAVLInV5O9jRvl
         MrUg==
X-Forwarded-Encrypted: i=1; AJvYcCWCXMpf8IkRbUD4zJh8OtZ480zQ1dzCvoyeaYcl20BnjmUFXZMGxe9dJdHak5N36ysXaI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNu34rp7mxjViREAKZxwgIGs6BjcLiSmxnljiIFyUNpPGVdxhA
	P1QN+tCD5jW1a/P3C2rg3cLF5+tg36d3FIQpKirDZCY+lxKx4BtYcsIg+ZuDaC+yX5bAz5ME4H2
	FBywHlFNdbaae4mgUl/0XrIlU5vRcXHPNTpL2SRN8
X-Gm-Gg: AZuq6aKlq6VaPNT2GS8p59OO84R92OJqCPsISr+TtHBIX+hCIUBiYrNPslvdfeV+KIT
	qe6wWTjxSXI42ll3YdwSVDcdRzMvVteyngd4MxzfGQvrT782JF/UEuNWZNGHhH1ZMkMqEEV4L7+
	NEE5mrVGQ+BAmeDysbVbk1AYu/e8q2DtUTeuyNPeHMmPAX3XdjiThmGObxrUc2Tpp59Z/bZlFWT
	o+Zhj+KqWDdoviHT8aG50yGkU8Xtt25jMS69PYSVmY25JhfJUpfLYTwkbhru5pg17l4y48=
X-Received: by 2002:a05:622a:19a0:b0:4f1:aa52:878 with SMTP id
 d75a77b69052e-502a153b0d8mr241578331cf.9.1769006776632; Wed, 21 Jan 2026
 06:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-12-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-12-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:46:05 +0100
X-Gm-Features: AZwV_QhmibL0dUAXLsxhUO5inqdEXXTvbJ-_96RoQaEHVZjV79Y0et9q-_yyNck
Message-ID: <CANn89iJ7O5+xjoHHy1RZzLMfTBke7nmh+YhHCJsdpyx=-ewbOw@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 11/15] tcp: accecn: fallback outgoing half
 link to non-AccECN
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
> is in AccECN mode and in SYN-RCVD state, and if it receives a value of
> zero on a pure ACK with SYN=3D0 and no SACK blocks, for the rest of the
> connection the Server MUST NOT set ECT on outgoing packets and MUST
> NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
> MUST NOT disable AccECN feedback.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
