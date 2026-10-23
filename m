Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764997;
	b=VilPs61V0VKsygCrgXmn+LCoqd1AjKuMYyF0NUcdlSE+l+0/TbyeNes2ztCxHQ/kexi/
	 me4JfaPJPDnwGH2OuTU1TD+YhMrH2So2j6xu+hzaUjtRejanLH0vZTdUkuDsBIMxDe/i/
	 k6F2UmYA3LECpGVTKgsUonR6GtrISpxuSFH8aE2CA6EYYWKbQOJbDnA6OGayq0tkwtV7E
	 vjaYEWD9m5suI2Bvfaqbbfk/7il8HkQs7zCMVX75euH/sCD5NOTnJ3yi7uoMB9xYsN1ZS
	 62Iq0s2dXIGmuciNgHIb2Ctse7nbV8UJdc/Z1XjI4ePSqGKJ2zaFc8zCo27DzSIoqtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=efPF2VG5qF2DT+I2B1WcV6GWpGeZAdrBPty7aH2KWf5ik/bz9m4ocIPVlwV1XhxxC8c2
	 2KlmySbgV634jREUDaD8fEUWdBYDDmmPh+HlJ0Et4a+BDfXDsemEgtJZXVepLuRJq04cB
	 ESRFpPsKLwyNjg+NWuDisB63onRyg+BrLvf8F9KbRobT7P3F5EcjpH0q7a4nUd8STc1OO
	 Cgw4cCOqM7auRKip6X/033pZHVihePPYtEeV0dHoXvy7exuuvJP/Xx8nU4jvgiyhHm1ue
	 Dcidi3P7CiRkRoLlcCP0JsNbfvhtTDParLRJzlmGLE6GvB7seOWWE/NmEirnOYj6/7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoX0zDV3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CC606A327;
	Fri, 23 Oct 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoX0zDV3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29221F01828;
	Fri, 23 Oct 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792764996;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BoX0zDV3/cysC/6BALN3iatWQRYpb5H2kDHaE5Re2qQc0McCIndzuUDTM0+z9pDrg
	 TZKYcbIhT0FGAS4dUJN0bT6fkoCrvCVWaRrHO7xzSt0QXd+Sd/eO9TyzFbDn5SXesb
	 2Y/KxsULEFwwLsVe7EUv/DHyJ3qUTy3NxK/B0h82GAwIAkoIMIg8Yi/RD2aUDo4B+/
	 zir3lmy1WA1jE9Xw0DsN/jdEMiYbqRjL0Y3EGXH2zmFdmvmv0e+yDBAiQlUchYBAbZ
	 EsO/T/2D8YkxF+Phgfcc0PrXVOkUET/p/PlhEh/IvvR/fR4SqLMcIl0YNniFx/8qla
	 35HO5azHhIYxw==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Date: Fri, 23 Oct 2026 14:16:35 +0000
Message-ID: <179276499536.3327.2674391031810316709@kernel.org>
In-Reply-To: <20261023141317.3904442-1-p@1g4.org>
References: <20261023141317.3904442-1-p@1g4.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
