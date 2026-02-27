Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126236D4E2
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225546; cv=pass; b=TJAHzkCItBfXrLOhfBqWhqhqGraC860b/uZOQnRSiZxYmBgAb63pLEpDRpj+Zw5R6wkYZgTNKc1AW9UoiCWNPscDu+4dDa52psoW5cWpvVe+tgZdJGVcihkU6RzpU6tMswfVerWxURinYxvmUNrYEMDStMXj+n5Yn/QagmAt62g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225546; c=relaxed/simple;
	bh=tIygcM6cRtUQKnLeh3AfwHRi5W4L/45ygoA9+ANqpyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAJeHbSuILjQhViaezPIanOWZdYNu6/jSS7qLgia3sGurtko/k+KPXpHWxlvGPdhCfFUprinwFDSTiplXsn9zgnPCI942IUdDyg1ax46HKjB9Tfw/wfVONPb7d0eWb8COuI1vOnZZEJ/sq+dZepbZIXcnlR+RDwjiEEiO5Y/6ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HWh7cEqY; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=QZPlrEsc; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HWh7cEqY";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="QZPlrEsc"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK4LmG4076739
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=default; bh=T/yQa6BgXqNpw2Qz7tBnZUnFLT
	WmHSzLy5oxbr8AsWo=; b=HWh7cEqYISvKSNYBrbgXFm+rxnnQpX+T1rmHqlaylz
	mnNw7s4fTDHgYabBtAuyBrZ6DnqbiuraDMyUf+kR9K00BPxX4PuEzbylVsG8mYmj
	E2muFoFcvp0U9HAaqG2pQgp/vEgqbMKZ1SydzUfMjKbdV1XgqPpAk4Fqevsmvu9v
	2r+YlUf/VLXq5BQ+W/LoM7aWGlj7xqelGhhS+B7ThNYW4PHkRtGr/N8oCFAQQJuH
	zny9f44Ix3u2cEj8y9YIMUW8J/K+oZrjfoYcHRlttZhQyJ5dM+OYPuweoHndPq/k
	JjdV76WsP1AhOGUvXxVTxhIVDL9q+LE3rKOQukL0dfIw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ck5gvavpf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:52:24 +0000 (GMT)
Received: from 04WPEXCH008.crowdstrike.sys (10.100.11.75) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:52:23 +0000
Received: from mail-yx1-f72.google.com (10.100.11.78) by
 04WPEXCH008.crowdstrike.sys (10.100.11.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 20:52:23 +0000
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-649deef077eso3620626d50.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 12:52:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772225542; cv=none;
        d=google.com; s=arc-20240605;
        b=YYHtjqEA+s7WAP8bMPhhWT7JijWP3YqgN7wYzCSlHoTXl5epjT9ZtsKe95UkGJJ9/P
         tJ00IDbRsonmuW3XHn6x+TjN8YCzdTzdH8m0c6h9HM4ezQq6GD8DbDThRu9LaJn1FFfL
         i9y7bRQ5qY1pyAjZr6zag6H8Sq91rrE3TrtXkttW8hM4hOXVhrZnJ9Vfr5lmwQ3QGC9z
         760TeoKyEHxsztBkxC6yV7K6BSXDrPj1ZIhWAnIPa9uIzbmqdmtYHsQygEADDTLYcFdZ
         vo6p9ZQ73jz4XLhfU7EKkSrd/Ebsgv37ceM1b+vxKYL7mTZzparphG5m+W0+nA+wXwt2
         wjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        fh=LQFqW2c0gJiNlNFNYvLqnOWK3YkpcNvAFF7ci552+/U=;
        b=Ku91shfjmIAgORI3nJd4nW/N7v/AzSikbLMkYhzkSL2dVTVoonwT3pKmFG2IuisASM
         BX4In9Xc6xquEIJ0goWyhgLGQrqoj02PIKyKZW9r/b6r2kvS+shKy6dFqhUxYqIODC4v
         OsZIZUNNhd1gNhxiygIuAw/6jGyfWO/AUmnnbxu2aNBGZKKoNnsusUSvU6Y9CkQ7MtMZ
         58A1vg/AaBk8mAGAfUSTx4eHaIVMcPhLI0TL3GUrkhiGxBCJhsYtckiDPbyq7qyMbRq1
         +4BpD2eHaA441BmGuUP767oyvQHREnRjqVxutRw9hURs1OKDlLe/ke6DNitmTyYYoMCO
         wSvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772225542; x=1772830342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        b=QZPlrEscQw/cV+kwA0PFNIUe5rHgcGHbw1BRLGc2HY0n4luKgnjUMElS+q1dLRUmok
         q5xLK93tr8tpSjrrDQaA4w3AyGZP7QospF5IBKusdvkQKj6qh8vyo2TPuXaz5KLbHefG
         EbQbYfZvzdjMdmyQ6L8zwWmvzkSldTgGPdzULOVu/q0Q7DJKXY5ATxNNuN99XDlgHSeh
         qPgLYrrrygAgTcjAxu0UD1E+ivHar/JQUlDWDrC7LKFN1i+p8habI/evNdljPdOfOeF+
         qnsUXFsmTcYWfB2dI5gJT/ZVNwOSiAaOVsWT2g25yOuhhhgcFo/1YUiWmYcoLIBMhbML
         k/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225542; x=1772830342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        b=HvhO4JvzBHYNQRHxkgPgh/hGULUQqit1AxYLxFy6tCjQgmmeMd23vlKCGClD1A3Fwr
         faMa6yNj/Xc8xZU7ouOKIpEk7C+IGLqyj3U4E7gQN/CIlRIp6h/k0tz/s9CY+8CKM03R
         ECyxl2z1i4I548ZgCcXHJ++KnLxPC+vf08YuR/QmdLdlbc0+5us7VfdUBRB/UgjZQFYw
         GBG7KoSSBjS9OZ7UH97mRdzvfNa8gCtlv1tLDginApOTVG0qv4y322uqgq8QR6h4ZgIJ
         NzuD3ph4C0beCEcP4Bxob9IS4JP2V4MsbwRL36xXjjp1miC4bbEp7s7+k1Ik3htHbKCw
         E8DQ==
X-Gm-Message-State: AOJu0Yy+KuiNRw6bMy5biP77tdZ2yrj2SJHeLA4RBTu9XyZHzFuczoaD
	eejSLV2hYe2cJdDKbHrGT3NqZCIlW/wc3dyKr2Y3ng1RcirGPUG8rF213eVrQ0Q7HRyce3zhWI2
	PyagzZkxsAdSBVvD+pA2apHac43j0G3JBFKgvhJyWGvUvS5nyQC5CDSDmDMVenPuF3EuywaKBmg
	fBnVgtIzNa16zq5Lry9a3aUguEA4nSkQ4KlmrGCXIj7Xc=
X-Gm-Gg: ATEYQzyLV0vlr9RUUmS6pOp2e+yZk2pSRTSO/R6AW2w6H2zKy4+GhjAWk8J2qB70qR4
	2YIPILFZF2yk9PLi+AKNL9XOgWAxoehawN5TQ3W0ouQDY3y09gZ/t1SlmjrbB74UT38Wa8qKe8t
	fwD3nb93Q69yqVFsqe2Ri9PU3La1gCUuNQcyxW8EW6Oe59F74ZQsKLi3u7m50qlvBnL2OK2Ldit
	504
X-Received: by 2002:a05:690e:687:b0:64a:d6fe:5e18 with SMTP id 956f58d0204a3-64cc22fd002mr2646350d50.64.1772225542638;
        Fri, 27 Feb 2026 12:52:22 -0800 (PST)
X-Received: by 2002:a05:690e:687:b0:64a:d6fe:5e18 with SMTP id
 956f58d0204a3-64cc22fd002mr2646329d50.64.1772225542085; Fri, 27 Feb 2026
 12:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
 <20260226173342.3565919-2-andrey.grodzovsky@crowdstrike.com> <aaHPfR_cOwKIm-lU@krava>
In-Reply-To: <aaHPfR_cOwKIm-lU@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 15:52:11 -0500
X-Gm-Features: AaiRm514vjjY59GDxNTDSyOndmwoCXClwBag-rid5uBCNQXeVTsSFL_NC3gc46Q
Message-ID: <CAOu3gNj0EWFqJ1wk5Mqowr=wxrgMg=0n-nsSSEzLwPX32SCJHA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v2 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69a20408 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=5488X_8EJ3_aOaWkbUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W2rfFFUzTFOAqKBi4xtl1ghy2mxYciay
X-Proofpoint-ORIG-GUID: W2rfFFUzTFOAqKBi4xtl1ghy2mxYciay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MyBTYWx0ZWRfX3LkUjrnlqV/n
 +czzpAmU7tB+ipCT8WTD8/b0EMmOmIQdYDAd8FLU+PvPpKnq5wZAxNhjhM/vZGWYWEX+rsPAcBm
 bbbYdTU7D4q8biFhpSpmlKTr8IZhFnsprSp6R2NyXQX9OhbVdlwNPqJeS79ZB3lIQ6d676lptK5
 aSqd2mx51NmXC0Ekiprz6eOMLLvKB+9g/62vPAHBZ+EFtn33CsZswqQAjdUd5Bhz9LgSDREzCHV
 XVSYcnWr8/fQV0Ogkbbo0rTuLu0fgYvQNMb2C4mfeNbUfjJ9gUl8Wb7vEqYf2FHnbNbN074Davt
 Ask8du/3GYWrUyabMspTXGE7EX1O2vn66umT8G5oXtUUc32U9ab66/VGViSJus1v2lMMqPCrEob
 vj1CtyoumhpDGDt0/9OG9m5T/aV1jCBFkzbNceyGIQ0xuGnVtm+NJPkZRlWw6qCXUBjFOQiBoRv
 NQ5ozFeG6Ir7ivtKa6Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270183

> -       if (pattern) {
> +       /*
> +        * Exact function name (no wildcards): bypass kallsyms parsing
> +        * and pass the symbol directly to the kernel via syms[] array.
> +        * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> +        */
> +       if (pattern && !strpbrk(pattern, "*?")) {
> +               syms = &pattern;
> +               cnt = 1;
> +       } else if (pattern) {
>                 if (has_available_filter_functions_addrs())
>                         err = libbpf_available_kprobes_parse(&res);
>
>
> wdyt?

Totally agree, updated in V3.

Thanks,
Andrey
