Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697598;
	b=r7MoeyWPP0CEL7leKAHASXczQqe3EBl7b3N0ptocp7pbs41DpYy4PrsaQGgwhnI42+nh
	 0D7LthQRdqe+/nmkCZJ67MmHAPpR3W2ODqFKIhti9pwwFlI8grmYR71izSFZtUJdhAK1n
	 GUNPSHM04Y66niYw2ggPtg556nGptmkDAE+2AgOfT3qT3HktRCRUPFfiFwWEgSAbmLVU4
	 4MeIEIcsHLWU4Paf4yb3BEy7Nyup4Xw0bxkgfBG9DwVlm+3+sf3H2/rKBS+xlBL7RReKw
	 6Hpgb9WVVCfzeYEe4JqMhffCn61XMo6zykiYaJ8cozWycHrWrg3+UIyuaXu6OgwaM6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lGc9B3jyrGJ4akeMJZzBnHn2T1j3IVSiriGjwJai8GE=;
	b=j0NgfRAVz7QepYXzPPW1OQZV7imQn0nD32xr9b5ggcE+TJxOyHVTyq860cP6AmBa922W
	 KowBOffHLpbqfCQjNAS0DvrCHcl5hxxAd8Qn1T2Y+rJrpk+ie6/Q62hLWlt9ZvRn8fdNN
	 7rKJVzzmxHWYl1kXfWWJ0OZkHX+fprGdT61chuCfIyyc2O+J/y+CdYvU9rrdchcsYDIxp
	 qpQj2EhcCKoM/epbn2kwbrHVn9BnlrDyhbcmPmLzrPIjPL/NGImYSXM99OBakczoyMhsV
	 tXSoLknTsompfivZEnDqnrVOa0NErPBiDRtQSjYmiRgkAWIeKs0iR8f0PJVwtVJUcag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FORWBKgw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F86606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30F86606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FORWBKgw
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so387549e87.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795697596; cv=none;
        d=google.com; s=arc-20260327;
        b=j91xDRP+YbMvJrfQOPoEqVhSSOybkLXyFDfWZ3uVIS7jpNy9qDJdfxkOLC49kOJuUe
         f5lDeWHa0GeNtTkgsqLeoarwn5rTlii6k7iStfGbrQ2ndQbiR35oDSlLsRFz+4+Cpr4I
         CUSXlK8OQeIvFt0WX7/4oVGh6AYo6kkHJywU0mZazi0JBZLTrTrvaa4gEBl9dKQJP2Im
         uirtJtHx0+l865wLCDShqi7aXBMBPXXYxfOi/Osm+eYsNSlSDX6+5Wu1suL+IEuliQH1
         NgkTZELFEO7wiYyo7uyRai/sUcPk13mLXdMqKAKS9QfPPm+NSwuGfsognxxclllY1db0
         xEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGc9B3jyrGJ4akeMJZzBnHn2T1j3IVSiriGjwJai8GE=;
        fh=xE8AEZL1wTibs61ROpHQSQ06g/vnZ1ApdlLKNgg9RiU=;
        b=bSj2yE12C/qYTGf6nRz1NT3hISMUtgn/szK7KxyFPSDPxRRaUki6T/oCRn+c7Ev8Io
         +Mg5yf0ZFD14lLGpWQs3szSKDe0zmxwii7mtrUNovWjD7c4/ZVtWXYxBJmPGv169AsmU
         Xh1qj2/ooCSARNxiFmPZJ3EXD0eRfVkbwSk2a6boeQWDKORLdBQ1i4NQi5RXicZMGSZ2
         vjq40uDYXy2/1WDf3aXXlDj/mKhthuhgHivq93ZeagmLJrAj1Jz7ulVBSFUVlsiZLEPP
         UNftOoG9OVhsKj1uPyFGOF3VUMY20VD4BIJhmU/Kl5jZ3dZ7In30plSbXmsrG4sDJUOh
         oZeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795697596; x=1796302396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGc9B3jyrGJ4akeMJZzBnHn2T1j3IVSiriGjwJai8GE=;
        b=FORWBKgwsA7he+yhIejYmX3C8mLyffMOydsVSolS5B9UxM/d6GN9EfR/WDQnPxM59i
         I8V6kZ/8BCzmnDAJZDiYTIggQsKvlYEoBOQ6VOaPjuRScNUe+Nv/34RmmjzPre8+QCii
         svin+SE79f2EIjvbqI+at/bTde6GLq2GkUerBK+q3/xO+kSqiqd390kpOWbo0xbmS3EP
         HhgnZyq1/RsPyte70TPtCraHQ1qJScwh0kGrn+u7cLEkNU1RZKh+x4HrDRvojD7cZ9+i
         7ElD/IEkweh4cSXSarOg4tsLELOaArmaKLCFc20DyW0O8+8DAbBqXtCU1of40mjEY1H8
         yXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697596; x=1796302396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGc9B3jyrGJ4akeMJZzBnHn2T1j3IVSiriGjwJai8GE=;
        b=HLLAOaBd8BIKce+y5rOcQpYyzDWLvc0X1/ZHJ5hga5/IgNobsTEpacI3nrH7ElCL4b
         TI6m229i7wVy7FJHIS1iGgK1UQfpQiuv0kQKLTFTeU3aNFtoP/vTimRguRoWa0Amr60g
         oFa5hKZfFM2WOuGlQQl++4SheLkUnA6M1tCeWeiBG0qmgcYlrTLYmvawnDXQ77xOq5w0
         bzRcPfhe4HRrSVzcE0IsMcNnwyUAqufidpvLICVtV69gnJhCiituVcpxFweVBJZB20xQ
         LPeYu0AiOuNxrXOpVF2CqvJHtzcQzaEdVAWneVfVW1MNmpukNe91/rOIqF7SwgqXq0D4
         6jkA==
X-Forwarded-Encrypted: i=1; AL+hErH+rZk1GnTi4E/4bSYyA/1FWQOIjHxvp1oLm1A1vpyGe6VcyFZIHVViyFojzGadl2CSW5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DbnJdak8rOgS3SOLNawX0F7oUJ41eHYQVtl0tLspvEwj55Hsy
	jcwQQlJTdWwKidl2Sfna8C7kgCDc0GJ9QfOAWoNlXXQOhC75ho0xUX8TVb7wFUHY3OBNgbSCMAl
	SzjT8yybbhYs1AaXdXViV6mXLTQEyo4s=
X-Gm-Gg: AZFdTZfC9Ur+4OaibS4VXX4u6WezwDaybiAMhFscB7tSivVHplqq5bJyDqUiLamiS2R
	NwK7iZltMh/1JF0xnjd+xByKY1QnYOGHUGfwyr2xs+yHIINMPISxgLPOnrNZCrtWXu4wnwJOi9Q
	kmUu5E22TYgBlv6pvbidMKQtBvp76RViNX2GnqFMVtSpDWjXhr/CX+gYipNVax3e4zyOiYFCrDQ
	qc2pwXQJ+DOATxyY1KyFhUAJYLsyqlAdkiqY37FoWMOmuUAOn2CQowbqsL4T2Gj1rFvhwGDFtNi
	dlM23v7BZDFJkN0m42iiR7fi95C3doOnXeUUCXT5jLq3g9jlmSOeL1xTDVzjuoJWiKY7l/0j6nl
	ta706vuVOShvjnlt7NJtcxE0htx/fCYzeCudWkg==
X-Received: by 2002:a05:6512:6311:b0:5bf:c4d2:b074 with SMTP id
 2adb3069b0e04-5c1bc81b1eemr5244475e87.55.1795697596151; Thu, 26 Nov 2026
 04:53:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124230228.3868519-1-graypanda.inzag@gmail.com> <DN3TX43KWXO5.JWLJ9HO1C9K7@gmail.com>
In-Reply-To: <DN3TX43KWXO5.JWLJ9HO1C9K7@gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Thu, 26 Nov 2026 21:53:04 +0900
X-Gm-Features: Aa3M54ptuj7zEv__cM-ZP_znEaMpCD4YLDPrlyY2oJoeO2RPwi4yvnEBtuW6DHg
Message-ID: <CAO7ntTQ0bJGezMUFMoy=_Ns63Pw_1Tbw0_QKtXVoh2Wst26Orw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid NULL skb dereference in zerocopy receive
 with sockmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

I noticed Kyuwon Cho already reported the ingress_msg copied_seq issue
last week ("bpf, sockmap: data left in ingress_msg is dropped without
moving copied_seq, and TLS RX then warns"), so I'll drop this patch to
avoid duplicating work.

Thanks,
Junyoung

On Wed, Nov 25, 2026 at 8:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 03:02 PM Junyoung Jang <graypanda.inzag@gmail.com=
> wrote:
> > Check tcp_recv_skb() before using its result in both paths. Also stop
> > before advancing beyond the last skb in sk_receive_queue. Neither
> > check consumes data in the sockmap ingress queue.
>
> This should be fixed on bpf side. Other readers trust copied_seq too:
>
>   reader                             with stale copied_seq
>   ---------------------------------  ----------------------------
>   tcp_recvmsg_locked()               WARN "TCP recvmsg seq # bug"
>   tcp_read_sock()                    frees new skbs
>   tcp_collapse()                     BUG_ON(offset < 0)
>   tls_strp_load_anchor_with_queue()  WARN_ON_ONCE(!first)
>
>
> pw-bot: cr
