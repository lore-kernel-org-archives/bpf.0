Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057886;
	b=SjrbEUulacXeVhPAj2TscKjfvm1a+ruCkbN6QqlC77AYovJ8f+MExW+expkmiRk+fZr6
	 h6gkh8VVfxct/OAmj7xts+QsCszuqdO56NfmAT9JnJQXFlcPJyJXctRlYuuw8hiQLbLdD
	 oP/1s4IGf7TvxHXtgS+fxt5ygIkCpjr2o2GUby7ZVI8YTL4vsFNRCwinIHbXu668vcma5
	 fkkodIGAPQZIQjGlquq7FuyNqK1iwAUfCkroi4FabE9DVcyHLWO+5CMuJQ1aAbCqrQrFN
	 GPMqScPPe8f5KWMQ39EyDbD1qcyWHgKqctO4N8byPELN2SPg5YbA4UMQM8Eman3vXeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=VH7ady2HZ4+2o2AB4BRmr/CzSYqljeaOTtIyqJxzjb8=;
	b=RFYhS8hrDT7zF+eiQgtyXNbT6isyUg1kxTXX3E5Bzvt5IFIvk6V1BXyhSo35ABGZZtdG
	 lKAHXg85JWAXtuwqZDBApHsZbz8xKrZrnBFHU1SZwHRI3UqSRuzG8845KlR13XbcJ22WS
	 ALxjhgq76iQJ0u6V19ewtWD3fz/mwnYoLOvOVgNJuw/tzqBte+JxOqhhJqdcv+eG1KHjm
	 tSpAbs1qo+tbALTtD4btTY09BNUg9SuRNru1PDTsBioXudsfyu+rLXMShYmQIS6KORz4Q
	 FnWS1PJr5KN3h/HOAwycu3AvRGN70/OGq3UnUayH/6t78+NpVsj2Q3puSkbYzMRuMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PneyK/Aq";
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254A606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7254A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PneyK/Aq
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad41b6b2ebso161641a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057886; x=1794662686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VH7ady2HZ4+2o2AB4BRmr/CzSYqljeaOTtIyqJxzjb8=;
        b=PneyK/AqAc8bt+o3y2n+IDeYoISmWksI2Y5Lcc/MKKrkI6U9u7mvJdWCpA6V7HeiJ7
         o3V3g0Gi3coSjLvyvQPF2DDIRH9dYSFPXaOe8KNImjTuhTtIgmvtXC4flDOC//s0PoA0
         3FBkqPKu+WiTDBDqHDbz0qCUFFe3fFR4vUe/NzuRWaOvo4Zfzlhzh4YFG5J08FxpSQHn
         QH+jAfCvw8EXQ0XeooNjrDewfiOjV1sNayM9T9cAzWqrs9TaRX3rRddHP9qe6z+lRvXf
         7WfWhXdJDymMeAlK5CbIyXCuRa0GbMZafxml6P8vNA96Z9rjK/F4OItOU6ioySEk+AKC
         qPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057886; x=1794662686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VH7ady2HZ4+2o2AB4BRmr/CzSYqljeaOTtIyqJxzjb8=;
        b=Ak+oImwn0nR1qZgoCgbjV+kr73A0n7JkL0Ca0vgEDOdywdSFEcDI3vnJTjqIJrT4iG
         oAulI2//C8LQF8Fo/yTvrdDw+AxrzsznirKoQJWq/9mMqabQcL7DPOLfWt75XfTim45o
         yRQSllmwYzpsAGWwhz5y8a0p7MUpVVGEnK7qo8HG9wcbY9Uh9kt9yWWCx8CgP5YHEeES
         oOKmyfXzr2Xv1CMHc+qY6JF2m7JBYYAWpdxM/TKvCBl4Hd69JtGpuZXkBIKKtvHU7dqe
         8waNfscE+Yu6yPIxkp343J95/fnZJUlr/yERbi9WC0ReXhsnGPJ3AlcahsECa2Cui5JE
         19iA==
X-Gm-Message-State: APuU4Z/V8kQkZvBpErQUkiYhFclV/9bfQztk9pWSpkU497lrXPwoCreD
	WeviS+siO8JpjuADM427FIYqbGcfqHKwVdAeQzI/EsyWdx+2NzXsZCm2
X-Gm-Gg: AYBFou2B67kq9khY8qSctzV4KxlL1Bt3EoeeT0gObGW2HW/CgDJigLexBLDiYGGDmjI
	h8VmuGIDCZ9Z3VH6qUkQMSIyO4iP62uOhxku86c2Q2NuQ73kXtogOqYyJZGXj2CeKtteVAAWqQ4
	JL39axq405dKUi0zAuV2g5Y6Te8B08wIUxUblRHrBIG34XKDx1oCK8QXcaLtMpavFLZsvf1E29U
	FdnOra/rUSm8X6dUBIa2jEJs6B4g8s2yPWFmd5QaTH+CpfXsLlOGSBexxEBao9LhenWoQanInIU
	VRTRWqvaLAv/kyYedDqbrzyOMHqtuMT5eByQ5ujSNgkZk9DtSFXfQQ0IpS/j3Ni+jJsMWKeOxTU
	/z1eO4+o63ChQlkYmSZikszsQcaXHmIYyVq+776+dLxl3j+dIuGciWfZUKyH+wKCU9ZSuamw4LH
	Gm/P3MESJpZcp2wd7SvZgg3yw6w3XDm3+Qj38fqKUM1bjrriaTj8J8xUvF0hgCaED6J4H5c+1ly
	3PD71QIf76pTlg2N35qShFr5ssZk17xAO+o/KZGWWMdjoDucV+4z/iOS2MK4VUg7ITLdcnw8/wV
	rO1xYCpgcNI3IfgOOfHRp0xb3mTxhnsCwwby4/q2x+hxs1OyTdPFug4=
X-Received: by 2002:a17:90b:4a06:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b106314922mr1376177a91.24.1794057885649;
        Sat, 07 Nov 2026 05:24:45 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a0475sm3386135a91.0.2026.11.07.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:24:45 -0800 (PST)
Date: Sat, 7 Nov 2026 21:24:40 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: reject incompatible socket assignments
Message-ID: <h6fnquoculybbdb4ygf7bznp4ou2jhtctiw6dkezvngozrbcps@zivgduwdvwr5>
References: <20260930164020.41006-1-shlomojune6@gmail.com>
 <20260930165415.85C361F00898@smtp.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930165415.85C361F00898@smtp.kernel.org>

On Wed, Sep 30, 2026 at 04:54:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: bpf_sk_assign bypasses family check for encapsulated packets
> --
> 
> commit bd75dbe60b27d785e5799901fce33eb038028e20
> Author: Shihuang Liu <shlomojune6@gmail.com>
> 
> bpf: reject incompatible socket assignments
> 
> This commit fixes an out-of-bounds stack buffer copy by validating socket
> and packet family compatibility in bpf_sk_assign(). It ensures IPv4/IPv6
> socket mappings match the packet protocol, maintaining compatibility for
> dual-stack and mapped sockets.
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 70dc621672f2e..173349bd2a3f9 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> 
> [ ... ]
> 
> > @@ -3491,6 +3491,64 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb, __be16 to_proto)
> >  	return -ENOTSUPP;
> >  }
> >  
> > +static bool bpf_sk_assign_family_ok_proto(const struct sock *sk, __be16 proto)
> > +{
> > +	const struct inet_connection_sock_af_ops *af_ops;
> > +	unsigned short family;
> > +
> > +	switch (proto) {
> > +	case htons(ETH_P_IP):
> > +		family = AF_INET;
> > +		break;
> > +	case htons(ETH_P_IPV6):
> > +		family = AF_INET6;
> > +		break;
> > +	default:
> > +		return true;
> 
> [Severity: High]
> Does this default case bypass the family check for encapsulated packets?
> 
The default is intentional. 

Rejecting unknown ethertypes would just break existing programs without actually fixing anything.
> If a TC ingress BPF program uses bpf_sk_assign() on an encapsulated packet
> (such as MPLS), the switch statement falls through to the default case
> and unconditionally returns true because protocols like ETH_P_MPLS_UC are
> unrecognized.
> 
> If this packet is later decapsulated (e.g., via the TC act_mpls module), its
> protocol could change to IPv6 while retaining an assigned AF_INET socket. When
> the networking stack processes this decapsulated IPv6 packet with the AF_INET
> socket, it may interpret the IPv6 control block data as IPv4 metadata,
> leading to an out-of-bounds stack access.
> 
> Can this be triggered remotely by sending encapsulated packets, defeating the
> vulnerability fix for setups performing decapsulation?
> 
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930164020.41006-1-shlomojune6@gmail.com?part=1
