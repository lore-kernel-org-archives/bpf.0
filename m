Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A71390C8D
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106817; cv=none; b=KDDEzNFe4nomjTyndzpBz70eIo2/C5Fs425gcI8nweyA7kIcHaRQ6Bq65YVQ3/loqDrqzHjsai39biPTda9lEEMNLOsuLebhZiPzv856pLapR0EnEMEnxbU7QS+7e7SOkDZ9UcZcD+ECshk9v0AwUavLkb2UqnU0mceEAJbEZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106817; c=relaxed/simple;
	bh=nYY1beQYVkkdXo0zEiQK/2d2wu37/NSprCjt2xGqr9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyxU5V6UR/WX0StspzKvcy27F81aVLF9Z2jqe6pu2kWW93BBt3uIxtOjKl+MLqF4n8anaKpz4AhzsdwqDd/l9UYNozCUShVhAA4fPlN3zmXfQrIwPek+L3oaGxssUA1V1W6eEqzkxWAueguroILOyWAGnv/uMH2/CWlMScKhyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T/se6eHb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T/se6eHb"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BBA3680F66;
	Sun, 04 Oct 2026 11:40:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZoA3e0z8CTB; Sun,  4 Oct 2026 11:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791106806; bh=nYY1beQYVkkdXo0zEiQK/2d2wu37/NSprCjt2xGqr9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T/se6eHbr2jdPWkQLDBq/lSMcrhAny3fkpgEOMx2g/c0be5RReGny5NtVsJOazgvi
	 6VEQsAQP/LANc8w9GSucM5Ripzy+FGsjLkpl6qc/+grtBGQoi12vZjgKwW2c8jai06
	 SlzIq15Oj2JFwzL0RiGqZvMvBr2jkTT/GvLHaukcgbXRhogztQND83kHxL8Net6IAO
	 sPeLR03S4Ts3cTTE8/KLw57Sh+MzbYHPAtjYANzxVjaNF8irIniZ60aVUmbBuOvwFM
	 SzFTPgefb+xAvO1cOYajmQZhPTbhlcscg+Z+4L2jQVsL83R3T5gDegoqiAKPsla5ie
	 plgHPB1Gf1hpw==
Message-ID: <7ba947c4-d753-4c70-a496-5bc3175b84c7@disroot.org>
Date: Sun, 4 Oct 2026 10:39:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, leon.hwang@linux.dev
References: <20261003160213.2641506-1-maghasi@disroot.org>
 <20261003160213.2641506-4-maghasi@disroot.org>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <20261003160213.2641506-4-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I will add fixes for AI concerns in v4.
