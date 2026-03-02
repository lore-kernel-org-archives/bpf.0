Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756B3859D1
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480866; cv=pass; b=eT94gxVnhd1mSFOczu13odxqdNyRsxpCxEKERuqkggl/4KLTJl8n5HwhJB9aPbkiVQ8dM6B1viDd6zU9hUbQpvvN6dAwrb+2ulKRG4IW8bXTUM9daixVjGjcsw/RrbRQ+XG3k/nVY3uGEXzGfoK93CP5gph9x9f/GFvHBaDYjKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480866; c=relaxed/simple;
	bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQB5kRVvxwJY5hWXFtgUCzd6fpDIWfdkI8Y6kbcHvkFi/ooOpNq//dl4b2PjahqgAzLJLggG2XQ3VL81N3Af/MI9wa9dLcwMNojQTOn68sfaTDTm9p2wO1JHNWFWOX12xfTWmWuXZGc8iJ0HnrwqmhaVXRkX5jCv096MhIYinLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=y8F8Lj5D; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KztfNn1b; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="y8F8Lj5D";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KztfNn1b"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622I0fsl542577
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 19:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=; b=y8F8
	Lj5D3bF5iO+P8RFraCe0t2YIMQoNvY+c0pE88AiZsop1YN3tWjQDRllderPGUxtv
	l8cZZ4cquqJJcqbjxIFeEIpmBgEdKHzIku9vB61q5NhVtVEUuEo53hEidNNAvbi0
	wp2YpaFckqCK5zmeWNCrvZPQOWm384VYOhF5+7Xop0NgRAuIZleitJOvbePwYfqt
	WMCcTO7IW25JkW0/mPxHBqscp4yZ1o6rH9Zu5XAQABMxplOxmfRP5nIcrfi1cjZB
	sFa728oYLlb0fLBNmHWvdFys0aD5Nbdd77ED5uEZOEEPu8K/si4ifZzbfCUbRkLh
	gKEWefTxYssmJRuhzA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwdyvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 19:47:38 +0000 (GMT)
Received: from 04WPEXCH014.crowdstrike.sys (10.100.11.87) by
 04WPEXCH005.crowdstrike.sys (10.100.11.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 19:47:37 +0000
Received: from mail-yw1-f197.google.com (10.100.11.78) by
 04WPEXCH014.crowdstrike.sys (10.100.11.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Mar 2026 19:47:37 +0000
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7987861595eso80300307b3.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 11:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772480857; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFWeREhBhsdAVpeBKrz44O/UDUUL9jH1C14jPz4GVx+/5K2Dk0LWSQhJ4YWAjI/Wjh
         +5wKuXQSZmk/04K83cgb3w1pZtdboUrgRJ/KaTylr2l7dGbHM5Ti+j7sIEqCpcSHFG+7
         BkoKApSZs5iqR4AxGjcUE76su14W8pcIROX7toHLMp7OyYK+VIfeX+c7TJaY3qzct6uQ
         7O0bZzwzQyolEbwhn5RF7apCRAS5PhQ+6T1Y0SyELlpgHDkR98nl3Rr23+AjqTyFXoFE
         phc6viqwTnNkmCyKZbb11qLc8bmSv/Uc6PrgT+qXGzu5wnPsEfNFij2lUOqRUpIqk5Zn
         9dJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        fh=2vj4uhLZOZUlTGLc+7mWGDO67eE3AiiTRAwXFyO7XOo=;
        b=Z41414AWBScpXSVW3bhYJLp2vlfS+5BKyj/6hb0y9kNiRjDq6T5iquTQ2lPUbc1yLo
         t8JeDP3SJHbEvTbE+rBFd8TgLzs2Z2Z4FkrYBInTUgM3OpN2f3VWEwsQPYdOWbHz6vJS
         qBCaZ1gZheD6/rwZouXbDQpgsgEwSa+QfsoJqRztW/1AmWnFy/cwnLEZB6op+poJeCKu
         2gIbDqRIySlrKWLLdhpsJqnUeKZom9pUSnlGHm9xZ4jU5tOTR+CoWE+gh2Sag7e7HCGG
         yKZ3y+fcrEiltCo0vZKvSePhi6ec19QzPTtbPRsrINok5S3DsCeuq9quNyXMC3KwFJwz
         qSXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772480857; x=1773085657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        b=KztfNn1bSvwRRW7N6axUV4hRD+pMS8Z5cgOB/F9Rcmum5/9Qgs9dzg7CtHWCwwle4b
         8RdcXpc0eZlO1Td6ObOHkMDZBjXyhVsDukm3UbnLU6AlZ6kkiUmI0gegb0W/H9s8TOQ7
         YPb3NuN7VhjJNEHd2u/6+WqYV1Ln1UdhO8q2QxMZuDJVRqr0YtRYzcuIFgx1JyVLYXHx
         m6//jtXXpM6mduw73EKKqWIs0AJgDse75TfdwJFItMQeI0W5M7doukTijv9jnrc4jgqA
         1eAbh/Qa/8dkrX7cZsWfZvv7Sa54C8Q2Fm56f8PYXDGcF+IDwy/RabCLhLAsfAt4K98H
         Oa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480857; x=1773085657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        b=aWizyOa+Br9mHe/7HArfJHuB3lt7Hs7+d53KJLR1ZnE3VpAceqDO/xAWHdegY7xugQ
         u7hACFarbXdrPLIYFhB9tI2crp8Q92aJWqokaX3SGzzQXhKHUK8TAXRmFkgCktggetdM
         ouQeaniD0YlQq1oycaDvkML1zntJg1Ih3ZM5nHyWpuhawsUxmmYvUmox+rDgS7Pdsuzv
         sHuhwWzok8Ep2gESRUAA8paayhiFilVl2AzEO/88pfLmSXITFjSlbbdbwXLibC3BG4nt
         8yl6UaP10d4vElO9I1VLGLVZLteo/Gi2Lmck425mRi82WHqsX+BMSDOLhqajQuqpAHoR
         fiwg==
X-Forwarded-Encrypted: i=1; AJvYcCX7RbiAPudTCJ9WtqvLFaSEll6WQu5Y+6NdwYKqYegaxQS+dhZAmV6cN4RbKveZbIMzHTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4Y4oY9S3zL5OwnD4P47Sk5N6ND/Mlhn6vNJ5WLx66plrFcX9
	bLrb5suXIPMn2IoTLPHLigrBzr7zy90F/75giJTAD1zzrAM0n0/D1eDbLL32SbGTdb4/jPluyCR
	xIeLCfUFiZT3ePunI3sSifGeWuMQIZEn4bucKQnVT+0mXcpLee7vIKVqavvlF3wHK4CxjF9Sw5g
	q553hf9DTEnSbAvh7lPG5cSkYwNKWBdbYZ7xQZQymCy3awXpLeAzXgcw==
X-Gm-Gg: ATEYQzzCqGM3VQVhfEeF054PmJb/e3YABKKlC3fwfEE4dSi67jBCC4wTx7zfeTWfwHI
	LpMojZWSZzPD+DCmf2blP8avc0B9qTKUVtwYg8Grpe/7OltYNpmOYDPjSa3ZufKgxgCQCxTUjPz
	QDj29+/23Z2zTdzL94TDJDvQhnsEeE8zHudZwUHEYTeqIUTcuksGoR7dQ+tw4mMZeSIkccFzFvY
	2zi
X-Received: by 2002:a53:db52:0:b0:649:e501:21a6 with SMTP id 956f58d0204a3-64cc2081a47mr9408373d50.16.1772480856737;
        Mon, 02 Mar 2026 11:47:36 -0800 (PST)
X-Received: by 2002:a53:db52:0:b0:649:e501:21a6 with SMTP id
 956f58d0204a3-64cc2081a47mr9408361d50.16.1772480856249; Mon, 02 Mar 2026
 11:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
 <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
 <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com> <87fr6idoek.fsf@cloudflare.com>
In-Reply-To: <87fr6idoek.fsf@cloudflare.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 2 Mar 2026 14:47:24 -0500
X-Gm-Features: AaiRm52SkEh1_o00QJw02Lqk_CSzYQ0FbvrjSRE53OE4AZmWdRltsfr4nc6CHYs
Message-ID: <CAOu3gNhZeV17LtmWePOtuwwkV=-P3va8dO7NCQEaEXiyvaieag@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1MyBTYWx0ZWRfX0XzF37DB3SzH
 oRHOx/smdemfStFQYRtbV+B9KPdSWojoImkMMV+6pTTv/jLAYwTm+YOl3p3APBrM4c0Vwtdrwg/
 5yYCqodBlbB3wzFQpSnIeUk/D0WBJ/UNHc+e2IR2KLjtbW9wU+Qzs/+wO2U3Rv37ZD4ZiAqNcVv
 lCjEDNy/yGmlWkEulKhh2C2TadEeIETaqIj41k+ArICJaZmmceH0IQwEM/ZjgBuF9jAP82YwWOA
 18GHLA4ADbHhsxQweJzpFXQ/Wz4kXpUZu7H3nZvzTTxS02qFY+14xMZ4gZusvX81uGToamQQiB6
 KGSULZGb2XWkOaoIQU1CXC2BQTQ5I3JnjeaEdpgGAmWh4/7mHXCJw7xRzaA3SnI1qWAEs8GxMaK
 5wIMsFiRTZY+XWvUu85GfsKwBCBxLESP+ed6Vc1ajppIZZtY4aqMdlmwHyrKGXl0hB5HgRYSteo
 tbKVChOX4sdHEcHNMpw==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a5e95a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=EG7W4yiQAAAA:8 a=vSHqNH6RiTyX9nJUl_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mFNpkKLeb4Q_nOFsqWpUNAtwfnpBYf7J
X-Proofpoint-ORIG-GUID: mFNpkKLeb4Q_nOFsqWpUNAtwfnpBYf7J
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020153

On Mon, Mar 2, 2026 at 2:25=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Fri, Feb 27, 2026 at 04:15 PM -05, Andrey Grodzovsky wrote:
> > Hey Alexei, just to be clear, do you mean drop the entire RFC letter or=
,
> > Drop the RFC prefix from the letter so the CI pipeline can be properly
> > triggered ?
>
> The prefix, not the cover letter.
>
> Although I think swapping the word order might also work ("PATCH RFC").
> I've seen CI run for my patch set when it was titled like that.
>
> Kind reminder to not top-post :-)

Yea, it actually did run for me anyway and your comment explains it.
Anyway, i am dropping the RFC prefix and sending V4 soon.

Andrey
