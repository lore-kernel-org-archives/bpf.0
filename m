Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F542377E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053151; cv=pass; b=mcLKVUfoO63U/FhwIPVscheQlJ30O5elsgyH6QeCbxIRAl4KUBjvBGW6h7R5iAMs4RwYIinGe1XO4C4xuKvhimEhUVzhNWu/iECSCNnFu1ouP7/XpW3xT8iuLm5MFrTpgsZ/lcno3arCKRSoZ9OTsWmVohnb2rMgbGQ+IQyqZzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053151; c=relaxed/simple;
	bh=4j27c3ITXpBErSHQ7ijBlE2exB417P5mbmq8l9SQNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/vZDm3ouOOdNnwNfE0izj66YnF07o6w9EJIU5AJ1p4wjviQkYWBKP1heWACtex9tnKI3plEhg7C4hx7lgNINLh3EbuUtSpjw3Et54+RURPAjYpDNlOwHFG/YXMqrRPNVUNNBhgh0JKataKYRsu13NBrOse6WyPNui6K2CEJojM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EpeLMTVH; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=IG55PzML; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EpeLMTVH";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="IG55PzML"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676LJ8I6778088
	for <bpf@vger.kernel.org>; Thu, 6 Aug 2026 21:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=; b=EpeL
	MTVHcxv76x1tW4kL6f0PWpDMX88pkGsCejHUiuCnq8z0xx8/3XgnQAU3IJt1F+8M
	dlF9iyMhSAqOLCD20RtoY2tYQaO0B/nGwS/ij6wLJ/JG0q4kd0JvPqCa+g5o3fN1
	PgtR8LsQ1hOLOsCNu6+TIqPh6YE+jQkRX9Ss3t1m1gVsWbIxXiIIgUdUAuf9lp47
	EWeUwFGewzkFtjI7p2IW1wTefeFIK4SJ5HDdA7/Jbo0oyC4YAJ/x1Lvr//tE3I47
	UiqVQlqgiUwwNQa0GEAvER8A4Shw7DvDm1pOnSZVOkAfRsb3DVYgHcmvS92dPX8/
	++RT6gGHJs2reTHbzA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fvktmmkys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:52:29 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6ae12b42so39799267b3.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786053148; cv=none;
        d=google.com; s=arc-20260327;
        b=IfxSmQmYFQFvpBzk+uOHDEhlXBRGFEjfgSyapvagxxS7xMaj8G0Z44yh1hUZExZgJi
         SjbIOJmaAXla/iGqckuNr1862k0mmyp9sKcpCDQfE8KuelHSoA3SEGfAwhivY2x9W9pb
         SZr0jSt8JUDXLWVTSmSRG6aVZNRTKcZWYkRc0Zl1Y4dpPed3RYDPqMLo+W2dtJF81mfP
         IfaZsFx4KCliAyOJ9hhMzTidxBCV+kx+yhQSHt1Ve7wJyJgJl5NPuIh+b7s2E+wZxjrz
         g8MV3uvWg7JSmQXMhkzvvmPMpy/fG+FnYt2nnrdkDbOBPnH9mdN2KYMq3ydPKnbGtc7l
         6p+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        fh=JhJtW9zzOCVEzCBLEyRHkJliHE+OdzQNFDwhlwWEEG0=;
        b=c0E1y3EX/rX5oRJQwNSFo1MDh5IyYftahJXaURub5ReSE+rvFnzdvcCh0nTjd7BqvH
         seXyVtYU08Y646ymUVMd14vj3K2YvMi76pODV0UfDSyPTiLCXXakUjLyKpXFKGOOFuqk
         87zl6HQPWstLiST0Up16N9p76BEI5ioYPkwczZ8dHEhn/LZZpvogb3uUFUVRlr45CQeu
         oBUAPCSi+zkZT0vHfohHi8YHcz8wfQVxNs2d//hI8dMCkGYdCb5xIviUuuRx51WDh1nv
         V7dskLUelDgQhnHj5ea2N/9WZAOblEFRhZVyPxNGBucc6mKKBk5hC4HfqbViI7nWRiYX
         LJLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786053148; x=1786657948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=IG55PzMLLNCYWzhBq+cwUO8E5Of/wmqPJPmzTS/rAITe0mS1DjeD0Kbq0pUL86flIL
         mM25R62hSyAn/KkErAQTQ4RBXpFKtQmPlMDK7tv+tNksUA95j0a1M2x3NMXFulv0Dab3
         Dq3hIyDdxswH3aa2vR9XXgzXs3MEpYgtuVq38MKvsOGmZLMiltu8h3Goz5WbIm/9yQ8T
         Vz0AxXRbUpRUqTxvF1c7hnZitkUbt9TA37aIIgMkwbvUjHLy+lOecqNo95cmS7opkDuh
         pf4TfGlwHpDWNoc22BJC+HOX2dz6V03YoinhUMq/aEmUkmdm80HcaW3nmreO9cXUWTBV
         ESiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053148; x=1786657948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=EjDEWZe+FbrmpFbrXErImEMX84UesFI5hp2T717lKB02VqO8yXSmXyNvxDT/dHL8B6
         CzagKmqbkkdoq3QRYFQWqpLdAs+F0tpZLENUFiyOx8aD/k8g6scoOvGDE4b3xH5D7rJ4
         lcivfe1I4Romxq2o7nYqeUAhZ1ISNUjQl7Gthb6N+56di/5bz1OTZgR05Awi+oELiWS2
         +f9iZ9WSIMLgx8EjRJb4lGyQFYVnngjMyzlWYQzM4W0lKPiXbnaboxvnNXrdIl39av81
         f0VoRnJFw0X47tqtTesp2HUWgSAg+OadI03eivqCFDZvFe9jXauWbxBepptNE/nV3Ork
         RR8A==
X-Gm-Message-State: AOJu0YzF5ZpmxicYYJsd88rAwWPYxfZ7m11Jpyn9K88rdS8u3w2oy48B
	FF1H/4BNBytuMdpdUsFqNDYdJRcz/UlHC9M+X/3lu6i8ki2jagVDOP37ikQIM9Ad5xSIHPt4CIM
	8IVPAnzfuR6o6wCUz1D06UmVU48sLfmg+/kauS94VTqe9i8eP6WXx+g5Vn+Zi0Svtye79RejlEV
	c6jAbbhApZQrzmEd1WUxXtc2ow8Q+V
X-Gm-Gg: AR+sD12cPNVDgY3CbiWod6nYeN39kuPy0e3jY+YOF3L5gbz8htpQE2kXgh+sUjlQ3UU
	LDqVqnO8Hzny8gee2ZjOgEPpYNGl+oD9wG6sNOfAkM3qLT94ZP/0go3hXwaY7YdqaUA2B5+VOtC
	cVlsBNyme29drWBF7QNcVsT//W5ukY7aXAMZycURRKYU6X4qiYDkHUTIcOUw==
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id 956f58d0204a3-66ac2e29103mr3422584d50.8.1786053148504;
        Thu, 06 Aug 2026 14:52:28 -0700 (PDT)
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id
 956f58d0204a3-66ac2e29103mr3422536d50.8.1786053147864; Thu, 06 Aug 2026
 14:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com> <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
In-Reply-To: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:52:16 -0400
X-Gm-Features: AUfX_mxi9cOXXsF6mNBrlNENbUcZVrExzFYiYnyltoL6hOluHOkwQ37RLslPbyA
Message-ID: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8ZZqlIGQOWWMN_6UIT_fiH-9dWo5siBT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX37aNAL5Fot20
 gbJ1J0QQWpmLqgysgm9k0n0CLMMmD+m4CQ0QHRJVbIfh2zSAIXa7sF/oAuwFMaXDONJbuDI9Qhy
 aGCpPBMh3cv/KuFInkViCuSsvM9Tb60apYJkB1vpcF5yRlDXr0a6
X-Proofpoint-GUID: 8ZZqlIGQOWWMN_6UIT_fiH-9dWo5siBT
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=6a75021d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=VIIMA12v6iqWkxtvh5QA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX3HAlxbFZTTye
 mVuqMb35uBmitCr7fFlIN5STbosDpdoMHaxRtqJ62yghChD3xbZvASTEAJZcunbO9iwJUT9omwW
 b6GJ8qnXuHp/AhdFZA/+s87hc0SuktO+O8hGvpybJUqvxS+3qTE0cSxgxsYilmGMDikCo0bfI3x
 BOSDjhRaWvEhV6jGXsMr2nmqKElU9l3TfYrG6M4+Ino2W6D6QOSpSNrn8wRQz7EIjh+azlnU+8B
 5jk3cJNK11X7KYWaCmtsoh4JzrK34b6IN/UN14LTlUISXoc9MEPG5+iuQGxWQd3NM+bSHwP9LVB
 71G+3q42nCfqYCtBLdHN7l8cAx6kFqoeXTD3QCnmceIUc48YCjFCaWUxGsUelJUFJG9wE3Y4G49
 Cs/U+HatjlzK1FjM95/zQ+uLO6q1ekiW4gDkqNmc7NGbdSGkZEoohgp5IRCSg6kV6OIBypjiXUB
 sENp0mnaUD9oB3KIpow==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060171

On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > callers rely on ftrace always being on). Refuse the write instead of
> > leaving it in an inconsistent "disables some, not all" state: return
> > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > unaffected.
> >
> > Update the docs to note the deprecation up front.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
> Sashiko's comments make sense. Other than those:
>

The bot has 2 comments.

In my opinion, the test-breaking comment is wrong as he looked
strictly at this patch w/o reviewing the follow-up live patch testing
changes which update the tests to avoid breaks.

The cleanup comment is valid but since we aren't sure if we'll need to
revert this change later if it breaks userspace in some unseen way, I
wonder how extensive the cleanup should be? Steven, can you advise
please ?

Andrey

> Acked-by: Song Liu <song@kernel.org>
>
> > ---
> >  Documentation/trace/ftrace.rst |  5 ++++
> >  kernel/trace/ftrace.c          | 43 +++++-----------------------------
> >  2 files changed, 11 insertions(+), 37 deletions(-)
> >
