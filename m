Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C879347BC4;
	Tue, 27 Jan 2026 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517948; cv=none; b=KABuESKYNswFFOkvyxFqCgo2m02XjvJIqEOwz9piPNO45u31WRWgiaLscF0X+fsw3b1FnJDm5/82+jjI/YNcsOh/yNe/V7V2obrd0Mv5PSwl79+MNoFHJTnw4vsV68apbZo3e8NARgCrjFkRg4HiQ+Bz1wej5RKlsl1IOb/pCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517948; c=relaxed/simple;
	bh=vaTzZtYSml8sW1fTLm8YueRiMtbtiE4LE7a0tXObr8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=posBNYZwGj20HmHg4jqHzOw4DGSVYEgu3dPviVbPxRknsE/8vSppY0PQh1A0tpbXSrf7RvhDFrSqrItx3GtOFrdFKkYrDrJXutgOwuDJe/1kCeWEUVNrQd/j0Kulpd9y9rT8AfcHrGhzlmpJ7Frou1r90tjC8+HjwABR+l9DEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=lM/lRet7; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="lM/lRet7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1769517457; bh=vaTzZtYSml8sW1fTLm8YueRiMtbtiE4LE7a0tXObr8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=lM/lRet7Quys3eY5GUdAqHEeoMuW6J96wj2j3Mo+MgO7TYYvybYeNgGSkxSKELa8z
	 xUBkkcf8VH7sxJzagyA/k3W6MoRMiykNDey0EqowqgA8rtwDD53Nu/ijPqNU8xkmUl
	 IBjFQuX7aJtmtKmqNI5c2TtefL1/5eeO33PPAbNLaJil6HDUW+kE1dSHNmlaqFDQgD
	 Eozg6Hu9kAhFs+jE5ng9GUszAqT3sRGywlcejJLlGvSzoN44ffvnCdywqpxAwRdQrf
	 tiAXET9dmIM+bzoAuEAKkXS0EsxD/CGpLoF9yKgLux4N8RmRWzQ16FQtgHgo4fBMkB
	 xy6eX9bjbTVgA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4f0lKs6L3Wz8sY6;
	Tue, 27 Jan 2026 13:37:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.20.40.230
Received: from localhost (faustaff-010-020-040-230.pool.uni-erlangen.de [10.20.40.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/tbRpKZSMWW5+I3Dp3v9y4eHfPKlEOUK0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4f0lKq2qB5z8sWt;
	Tue, 27 Jan 2026 13:37:35 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Ihor Solodrai <isolodrai@meta.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix verifier_bug_if to account for
 BPF_CALL
In-Reply-To: <20260127115912.3026761-1-luis.gerhorst@fau.de> (Luis Gerhorst's
	message of "Tue, 27 Jan 2026 12:59:10 +0100")
References: <20260127115912.3026761-1-luis.gerhorst@fau.de>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 27 Jan 2026 13:37:34 +0100
Message-ID: <87fr7rtenl.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This series be applied to the bpf tree of course (not bpf-next), sorry
for the oversight.
