Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE781A9F82
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158228; cv=none; b=c8MNVh1a91xOq6+SAQYHaURUEu2Le36EEeKsB2V4iOVOjGha8dBWdkc29zB1crFcztTQ3uSaLtJVImyGzSxgfx6khFSAgW2L4jPbea+PYlZHCeMuP2eSaIRtFyxkeS2oc4XMXtcpMZIjI52+z0nQadPCDVe3nbPHs+NwGCcJJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158228; c=relaxed/simple;
	bh=PVzURMJj9vVkscF6t2EtugGPpq3fp4jd8kopfkFzljM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CV8vHC690pN9R8TkKzyl88sEz6p+5R0H14cmeK5dYHT/mugvGi9ynj9Yn+Bc1UoPpfF2KTg3V/EArSg1c5MzVb2DUUsLdOu/a9uX1qFAGu+IQNGHmrfyfVM1lzzYQn+uBqVf7XYB3CSk1V0++rgMLVc9H3q3pBL+FlBD9zER218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shgfv5Xk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shgfv5Xk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so984620a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775158226; x=1775763026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PVzURMJj9vVkscF6t2EtugGPpq3fp4jd8kopfkFzljM=;
        b=Shgfv5XkXPRWL0wBKfXQ7b1QH2avwxFOzxtZAnOftybuYNgKR3UqsjvB3GLahbjvOp
         WNIoE/mvTOiqve461Ol0O8qyE+Aw3HPVYcgUubjc9QJMlvuuvJSjGONAkrkamZwgnOxk
         2f39p7Cx2GaWOHE/HoDF/YTqTZvAYWm01XPDVMwRq30RVacuLQD6QYwXpcFG/BRp/JY6
         /6SP6pWupDDv1/XXGhhQuSwJt02jwWLmyIYbUh2PCNevgBjTHxrpxubM1z4d1W9L8kXc
         EPrHfSrDhxoONLczkpc6Oaep21nrxOWQjDD8VvBFp5Ab6n6RwCNjG5jBzN6FPJoL8/IX
         l23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158226; x=1775763026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVzURMJj9vVkscF6t2EtugGPpq3fp4jd8kopfkFzljM=;
        b=JkNySkeCieFp2oLrGO3qW3+hMeVqIJmnFLt+UGxqID6lfctH5r16A1hMvP0gHbCTXN
         zzZnPsfCdU2zQ10Ku/zrdBYstL8dG5W68F4X4aGORMYFcgKypUqhfAnX6h/LjChE02A4
         hZvtm7nRmcHjWTKzTglIJjU2kIAQcERc4X+/knNDstWbjXf0jPKFtkmlGNiNrGT9BxEP
         b9Z9ySFu5PIXjoW3CIDyIQ7VQ9Hg94hHojlxYYC2dfTXFZ2PQFpeWcWT4ndoZfFBCZNu
         cCwsqG5sB2gWWuBZnseravunFg4QusGvsoRM5WUdH+8Dpew9PaiVHh7WyqqN1XudFGOs
         K17w==
X-Forwarded-Encrypted: i=1; AJvYcCUEfnixs2bmbI46zh+vRfT7yCdIE3JgWCJOHeJHZ3eIynCOcqyCeprMAl38QTneyyFURD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gdE5mGqtb+2nRrkOWwGYJ+r1bHwk17II1LaSQmqOwOool64N
	L4C3m4uPsbMSO0jVU5XKmSuqUGPGmKZQVL/50jsAhlCAEPhsQGhyJLq8
X-Gm-Gg: ATEYQzwObnmb0xxqlAeJH1MWMDhKYKAMuGKygWyKoyFhNfaEj/x13IcVZj7E0hqgjyW
	yNsBbzt8pH53uP5Etjmf8Dr/TdyfYc1xlGSo+D+PCUNdXPylNh6/jz+pyy6Q4aVOQQNmRYGZjw8
	5B2CgkI9SNG0BmMTda0yqCsXcipCxMJ1T0LkfGwMXcahPhbja2F4sbfcVh/oDJB0WpAR2rZfNMY
	Ckqpu+T68mCZsUcdcSNICe0IhIO4o9Lz9vmu4QF5uWreI4FRAbGNA3Cwm58I9q8n5vhWKZ+gGCq
	sc53QKxgzOZwiblKU/WuxTmdf9XXpIvgV5jbfCyYesNJCgLVZQ9jTFaxmujGeRNebVYh/5IlVBi
	q3F4DapMPKrBYCPOKyb+w7r/IIHmb2cIamJsEiyRJhg8V4PQvsSKLumxfh5I8fu39PqnemsJ31r
	yROAPk/VyKYLIpQ33442rA3SSbVW3Mnym/SDhYRblXrKvg2/kWVbSTk74znA6LguM=
X-Received: by 2002:a05:6a20:94c8:b0:39b:da83:91b6 with SMTP id adf61e73a8af0-39f2f17da71mr122464637.64.1775158226331;
        Thu, 02 Apr 2026 12:30:26 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm3486225a12.31.2026.04.02.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:30:25 -0700 (PDT)
Message-ID: <0a7a791930dc7b9152354d8d5f75d0bfa782c3db.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Do register range validation early
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Thu, 02 Apr 2026 12:30:23 -0700
In-Reply-To: <20260402061744.10885-2-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
	 <20260402061744.10885-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 23:17 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Instead of checking src/dst range multiple times during
> the main verifier pass do them once.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
