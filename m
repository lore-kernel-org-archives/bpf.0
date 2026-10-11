Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DE405F7
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734054; cv=none; b=LEW1DtcEgVXatD5vMBgQjqhe5NRZLhy+D/7hW4JoDAh/+WB1JurWUqC9ToK8G5xwGjxMMnaFud9uWv5Cl3iCH9quF5tdy/GEmwTTx2MDJD1fCaCuBt8gHbLE831L5UksCiWtpXzlzYBEq9R74jD+ywA5OX4Hq4FmtChH7KDVFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734054; c=relaxed/simple;
	bh=dYO/maoNsU1ictyRG2rbNyOg/hArhojWx5s3/2jYQmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=PL1dwqGCjYUbB6xsHduNwkqbiRcqvNr479bbfS/lLbOu7zKoBbRr3poQkcdpW0unR23qwsh3fq+rxv5hXsqLkaUwy0tmueJJcZRDxRD2aHnOjieB2Q1KzSLrqncjtBeuoICkV42V9kPVXK0yi5+uDW/clivKxy85FP86YR0E7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7TPoH8t; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7TPoH8t"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab62a8250aso630930a91.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791734052; x=1792338852; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYO/maoNsU1ictyRG2rbNyOg/hArhojWx5s3/2jYQmk=;
        b=J7TPoH8t6yFlvW3Xkid84tb+Kay6fp3/QFFxcekWiEQVzNrsHeS7bD6D2FJPW+xidQ
         DKMrmB1hxPcMhmJk9ZKiwpD0L8rIurMBStcMj7rEQiyh78ZWiNM/6rNVRMj3t0x5MvrL
         AwL10yqkalf9WUi2jFIvtHJfri9hDull4ML8M6yzMV2Cwg9MjCIA9bzm6x78wS+PrDT5
         +Kc5hpOePrXJjXV45skzsnejcth6xsliXAl+Ox3VHgAkXisiKdFsXR7UknYEW9/+2Bv+
         RaWgKe4zNmaddd1sqvu3tT3TDLgaFk8BywuYdCv6zqgkdvu5QYLMS0bXWNuY6KG+L95c
         y/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734052; x=1792338852;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYO/maoNsU1ictyRG2rbNyOg/hArhojWx5s3/2jYQmk=;
        b=wSIlzPWanXAWBFlajVOkgM4T0UI8dLe8Ip7WlqCzFFIKjXvd8hQLeO0KWPYs7PqKGg
         GORSsQ+4Ls9UJilF6U40gaId9qVB+1dVv4lEIWonzsUftiToFzHQNIVJxYAh38dB8ACx
         MdV7uAH/KgOHJcaOanz7kTCa4ptEBNwBVXhvso+J2ow8j/W/OozQ9pl4uj64AStdNmpV
         aV3t02wg8ffcbllJKp8hVY2ybeShugsYT9xOHsPFe5aL8btlxGXNKvlaeo99C3s8RZ93
         600pwIFKcvkPEq6dS9YZr6ciyTjNQx0AX9MdNHDwiyn7/jhbEGireXPW3sEwrbUAkooz
         pXpQ==
X-Forwarded-Encrypted: i=1; AKwUvBydovVisWc+8pYfmE95WOuHGeqSXdW9P+8ZzX7kemnFX66ertsf/Q28C8G7JlZlCtscRCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIGMknJssU6JOYIdgtk1m06G9ueBKnxPWPXSqy5vOGZWo83lQ3
	yph7V8WFVDxp7CZ0zVMgq3GLjoPDUp8/RdeZVJ8j4aowsCxBn8SfV2qrxoXOuQ==
X-Gm-Gg: AYBFou3zgaTIr87ugc9aclYt8h8RqFhkkFXziBWaX8v6PcG+lbfSWZL0XeDn+THKyU1
	fMScK4oeL9KkbbyHm5eSG3kn1FDB99IcROBqW24yYBxaSHOVF+a01kOXOsLXEaF6/gQjjSQiip6
	MHwUKMVrEDCDY3kUptCQ7DzLVzr1WqBE6hdlVELxZX0xN59UP7UVgsrzM3BbOrFY3T3Bm093c6d
	taRZpyHIYAkDG5y9Lu2U6CR/CJPwEYXmdFkMEGNswN5/coWQ7XVuc/zKwWT9r7lzaUFJS3Yek8M
	5Sl1UU6P6s2UBIJkBTGA43FxebbssTNehTgBD7puMYMhKxx2ymVdhne97l8WHX8emklBDIY92ew
	0L4lbwaOgjaus2z2IQN+ABUP20NJLfwdhDl/mYZWAPDBuFVhqWpuVaXMRB1sAPcgAGZHFV44N8h
	mc2asUTMXa4/D8QF07AG9VDRPtYlnDrla0uGN/aGtMG02pS2rWkVsTDpY7znElk1nym+CM9F8Nf
	YLBMbVwyifIL3EPGj9iwtwvQMqjFO/TqK2JkFE4DTVXAE6dbw5+ObcCrJkzX3hWtBEX1efc25bs
	e8lYAFKqQ6A+8Q==
X-Received: by 2002:a17:90b:3c0d:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3abb39f450amr1973678a91.11.1791734052416;
        Sun, 11 Oct 2026 08:54:12 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm10637540a91.9.2026.10.11.08.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 08:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 15:54:11 +0000
Message-Id: <DM24PO4YGD7W.L5NDLRVGLU0P@gmail.com>
Subject: Re: Question About Reporting libbpf Fuzzing Findings
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "0xStrawHat" <strawhat4224@gmail.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <IA3PR05MB998319C977A2E378F5CC7EF54DFA902@IA3PR05MB998319.namprd05.prod.outlook.com>
In-Reply-To: <IA3PR05MB998319C977A2E378F5CC7EF54DFA902@IA3PR05MB998319.namprd05.prod.outlook.com>

On Sun Oct 11, 2026 at 3:50 PM UTC, 0xStrawHat wrote:
> Hello BPF maintainers,
>
> I've been conducting a fuzzing campaign against libbpf and have identifie=
d 7 potential issues so far: 4 that appear to have medium severity and 3 th=
at appear to have low severity.
>
> I'd like to report these findings responsibly and make sure they reach th=
e appropriate maintainers.

Do NOT.
libbpf trusts its intput. We explained it countless times.

