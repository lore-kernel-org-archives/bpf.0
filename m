Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165F3655E2;
	Mon, 22 Jun 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114188; cv=none; b=ejr/zrTMRh9HpOqNP5BCwF45+LjvAi2/5zzlpF4+/tATdGxfM5KUjFq3htY73OVgJcZVcCC4VwDqtJYKqWLzuk6QCCjN2yFTgQk4oGfoBvMSrkJnv9+Z3I6Q2DAU/iP1SyFEtbOr15g+DOQXw8LXo4jSVsPm+0DHTbTPRENlUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114188; c=relaxed/simple;
	bh=SSKOa4wpFih6Hajrbw54y96e0wA4gL7/kNwHAq/j0RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfiHYdcH5jfa+Ja4B8Bi3h8Y1UyOVK7OPq3JBJoBc3rBSuXnt472Su9YJCuQ/at/j+M+2jMsv1T0xHnKdsCgyZdu0LO8bCqqiycHYuNEPz0ij15ye/EncsJZCGjg1+gYzKVV8HS+MQXtMjZCtgjNDhAH6QOg0QSz2KoTIKxxcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DneEu/Lf; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DneEu/Lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782114165; x=1782718965; i=markus.elfring@web.de;
	bh=8/z3334V1gwaqrmLpW6rwKvedu78DByDfXCTmd+Uh6I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DneEu/Lfms1ZErTkoGHljDwCZOQ7hwF4vXb34xrgNkVno3MPf0LKQ6ON3ldgokH/
	 vrHGreca/+DxtMnV1OlkDvBmUkYDyZ/IbMen3ar/xSCI1F4F6jhZ3hfkqljYp7rPb
	 6zCd7Xc7zPS1whqzM+q5D9iaoOHceJ/A61uaEyNXFPFh2HHEj+QD7p0hqQ8ney0RU
	 dHp2S+/WZ1uFdxBTEUiETS4oJM7uKAeqJf0C7+X+SqGjHwCHfYCKnvyGPAjyvxuaG
	 WRTpFIq9hUKlI8NnaqYdUKmFXelAqlBnFwmu/uJHQLqon4/qXjs2SFMT7il71OHQP
	 8T4Fwyks1/5UHiFj1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1wOLsT23DE-006HEr; Mon, 22
 Jun 2026 09:42:45 +0200
Message-ID: <9a1179b1-559d-46ba-9207-80bf561aba6c@web.de>
Date: Mon, 22 Jun 2026 09:42:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next] bpf: Use common error handling code in
 bpf_is_state_visited()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <d6622225-c765-4d9f-9501-1021df4687a4@web.de>
 <DJBL1JEE322B.28EZ7GUNTJP99@etsalapatis.com>
 <451a504c-d7c5-4cbd-9184-25156f2fc581@web.de>
 <CAADnVQL060PFApJ++juj5S6H8OQGFUHCepavrRrizh0ciBtiqw@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAADnVQL060PFApJ++juj5S6H8OQGFUHCepavrRrizh0ciBtiqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uUMU9WfhUpBiDMM36YhXWr2GF9Sb1yIMCuswBR/Q+XHP96cOiLB
 obVQ8k9hWoM5Pd1f6lHL+Njr/FcyQQxi4mHrCV7zr4h7K8g5VBiaoXVKlUp+zxSqJmEuUnK
 spyptzx2awyvyipxRCOD22wyg7FmPkifHoXJ6t8+A3xfujASmI6SLT9ShJRy4pM4QRDtpeD
 IioOvcHvlg35OUPe8BHFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bslk3ZsTudg=;UDCjvb1B7Usu0jDXdRfReQaME1l
 7Sc1YAnRru4f1g6DCd4VhVcw+4pKB0maYMdYpYCS5MvFsiOHItsMEiChpNg81OAVxzO+FUUpl
 tcQMx0lofydXJZf8TcHqZLEeC2QoXs63Gf+FriAPy/yj77xgrL1wkzD+AWG1FQgTxuVleUQm2
 n1GY9lQm9w9vjVNWOerlqqw8b1jlYfY2Lm0LxuzFXCXtH48Qc+vj8IB1HHmz8KrRAkRu++nlw
 r1OLcnwQ/aS5io2RO3Pr7DcZaYOxEDEyG4ynTuRJB3ztS95ApOtDJI4KrFqT2vV7Uc/7jfNHn
 KFsxKc00AFdYFL24EfK75mlO+czzq3Wp5csu8hHuhrt3oRWnRp/WeLjktDUO9heBpc1PS3mHd
 MUKTcAS1jyRGiVUeghQc6sHJ73UGkMf3GWBi/5d5U69vdeIaY7MYFDaTiLrf1aWPo1AFvDPIM
 mkNlXXc5cHiGFJjiZZkU15GSK4uddVqtaxoVafqyBqS2lAqDna6dkr8YOKduZ2B+0mpawiBAo
 4otxNiRWV4j2xmFJEYlq+W/XWqsXJz0DaGMDYOkp0JKpMGPAgnSxsA7AUmz9k/At6vfWAewuK
 5Pgx5iF3djkPXl+zVaSgaFcFcroEp63pmWXemDVdsofNYLruxeK0zfVSgF/xhSGTVGAwRkv4O
 t3EJBLiRvJjfqh1RGm9ztqASGWKIAdCmRLRS9lGbDjiJ0jhmFGj2d0l0Pab7/lIxGQlPAI5xi
 udqVdPg85JpHhZW/94wqpRLdQgf780VIF2ZMIIBTwB8IpWVUYj8b31FOvCWiKkVfuYwwd4l3O
 1FAkBY2fklrgKr/C+HuPXMT2fSMbJNZIF3b5Uxd8+bCLx1AnkDr3eoDms3Ioy6S0APYYsIIJQ
 ug+/gijWII+tOFWcQxAKNJ6kH74dN2LZn/q8ElWgL4shue4H/0121Sx6PfpQrubxHl5/GHS3L
 ye1EvBLdUQJfAZTRi2xYoz2KzmDZunP1ZG+DL+VG/Bp/uOaI7UrviCrCWJMxUkrmcRtqZwFtn
 qOyg5UVxv5dtgRh4e19MCdVjcIi619qQbNhFW4WD8Qszj6z6+CxQDjvHobuuuBeonwJ6KcdQf
 BoUNtb01PGMm1CuBr0zz35CQAbEjQz/DUNZonsirtqOUTPy74MoRioi0GAeBlGy/w/lz5iAck
 MCkzmeutPWPktCziX7ZBg2rbjQ+yuif+eYB7m+YX+0b7PAUeWJlRfJ1FYDMzDmnYFiINKnLBH
 r5d3x3XhSGkFBIJRyqAfv9V9U7TIjmXWRmaBrWpiPfa65mjIWfx7xVXcrccQ3YevJ87RFxDI0
 nheFKFghjTkGzeOV8yFb2BBT/SYRGnx9bx3vVDyoAF8m2nOHgfJL5w54HelXZhd1don9bk4Nd
 lPxG/uwomq3Y5plXLx9KNvef7C8+Cdh2+gPwbfKuNDGAkuVaZeVzKV6JVZdhJDeiK/cH3P+Na
 PnMtfFnZ7OCV34NE3S1SRwrz2SQO1zEUF8W4J8E0HXJySIcyLlu+rVR00tjUDR/Kob8ZWjRpV
 olx1A/2DbDU3xb+R0G/Fl42TFjskCasEXfv4YX/o4mLntysbWF1adzVIe8v1XX6CIiAx3jf3c
 QIr+QCGtRdL/VA5WvFuj2XDQhBZH3YUI+92rmWlj/n43hJUgXwUTqGKwofJDw9pbCmpNsDkyV
 JQj63DDGOOUzB2fgwjpp1guPKN2fT8DQoz4iFgI9U6god/Td7SHAP0gahkKJlWUpqlEJPznq8
 Te4WQEpngxX5CY1J9Bq7wE6qx9uj/F2TLIZ6d6bljBb6t9z+AvaRE2aKqegFPQUBUwlkJepiv
 l/VQ+z5XI5L+g6vkPeQkz4oDMlCJpkRYRR47hDha8SNIDpB182zomHgKEYttXinjF4i06UCz5
 eqAXEOEwM7yMyvRefJnv6VAfl9xLLr/Iof6vo29x122gBV3YQxgAAXBcKnGpI/Q6xQLUKzSxs
 vcn/DZGV/BhY1lOKLCfgC/L/CbLQFwP6H3rCnER0Z67dmfHEhCRko/zQmK0eS8f6D+IRlLIzP
 KyCMHqhosbW+EioJMovzGWEVSGZcBWfcCf6wtbgB+fhi1Hw/zGwlnXxEfon501O9Sfpp1UDq8
 yzqiY+e4bn4oK9dPLOU0xDxc7rIxy2HXDL231ZOvgnEKIF7IpdBOnEIjTdE93XfoKADoxxGQ+
 c3IQvz7CzroYhDra1B4TIB3S3XrC3Gt3kSRe5MAKYEXuIpIOpOqWWNge3hMMGuR3MBesFgXPk
 YovfpwMLGxVBroWbLs6ptZNsoqFIp4yB6N9Bs1gScWzMOrJLgatxLuxDxyAUopWf9hAtuTa1f
 Nlj5r9QtJGAwD+2z50QTZT/wMGc7fzRpZRxhnduI5byNnfh1T5onCTbQvcI6W39/Jagaf3eJ3
 f2GzJbpKFJxnJmG5DIb0WYZp8k053/sUHZFQFz8WL98tQQ14Esx2LSJ8daP9OXSwfTllaO46E
 KGxEsbtfgVWuqZaqfB7Dz/uQkuF4yjQ5LrTb+zs5FBqkB0ILbhnWs3BS/YGrHWlOv+7txisUS
 4TmVjXn1gxhsswOaeS0oI8AtXhWub7xPkbCXu8mlDFE3lJr+2p0GIcr0bqrVjNwP/vDx3VknB
 EjUxu8V0kr8MddaUIFqiW7GFq25euL7MT7+IATBowxlVv0JrAV9rhD8/24jIJF2t4MeL5adEF
 yrG1RuVzAZqpbCKNIOvnXhKTPi8VoP+e3tMu6cnoiBDmtFCLbKKQHRJci+TjlSDnIupSbdRxP
 GK0vwL9Bnk2K2TDwiAgaekbfI1macCoyfsL7ui1xf187nO5MACiQIFjsx2x3MN+MT1jXZIgoX
 v/YGURlmtf74qn285cB7PH7QIsZC3IJr3pfr2h9rm04kVnWBXwJx4Rln5kfdboSwpf7NyMYP7
 xkRPcHY2wNrdIHgE6pqkKP1mXig50K2qVXcUbD8z0xjTbi26j5GpiOEFz0wGHP8Nl/WMP808I
 KjCQlfe/veVD4Ni6Dm5OQEt9D7Xbvy/CFA5haj0/efwVGdXVnII4gd2087UcNpCbNiiN6ypRP
 jg9zqbV4SSwq0/ikztwvhdJiAzrjqz5eTkLMS5gQzkjW4wjut+Qfsizuf1vNKbzUxBwDE86bx
 FWhQHDT2mON/stZ6iQWeXTrhTVxXhQ7OLUAk0ggTdM533+w2V8dnLrK1yQvO9NIRDuemjehsb
 GXqsgCXyv0bbRla+dGAb7Hy65kNejAltGl3yZkr07dr5qsL+owU/aBoq0+W88ZO6M7YSja+4T
 xOlC5BQfXtaHetvHqaOSGmrRnCj65GMpyvPR8jWNDgtAYc07yznk/eex3L2li2Te3QgKtTtHK
 u7DHH+se4TJAB8RBCmM6+1nPfmiHiaOyRtqPBzJ4KUAGPhDOa/CZT0f186lJVQP4REkSXQ+j5
 j0Td4Q/7bGkSl9m/coehHinkBmsr4I0F2DYsfBM+iQDoVOSeoujbYSpE9ED43aLe4BmI84gdx
 tGGA/9vxvF9CDAAyTwoy7dPN6QzBVdwszFIb0U0Utz9WhzbMFQfynrfbcmOK8Gmh9zDMzHuO3
 c25y5mGmomXatg4SxsIUj5tvYltTn7tIckBVlED3bDwjNOWTY6Ycv/ST/I0yxcJWzNrDftj6U
 cCnensdyXVBAxTNzB6oDGK0C+FadbX9AZ+h4bI7jswX57jt8r927prLlHl9SP+VME6KoDlI7o
 gqLcXAGcx31h5NLq1aP7i/sdUbQpekfNtPRTyUNWeV2u7xIp4zjtYu/rCuOcZpVWxodJieWxp
 7Qs3RentO9BpERyoKAyXOFRLc2nx2L/J74xf+1gB87Z9psW4jv3TQC0ro1rked/MiErw+5ptc
 zH7VEEPGJaZKT/Ai9TnbsNruLsMIdTFKKNUyRRpzsSCUlfjdgZfAiSPUgOB7+OlBq2QIMrTEU
 R6oXYEDZyp6PoOuLWFwItjiJTQJhDOebZv/PCUYLLe1wS81hTfvu79BUfIW8Q2mD/P1JKVP6N
 bO+b0rVFb8hMCOoEntHm/l0+A05r4z84phzMm50JvS5XygVuloyiXSrFwFnZqmfKD30vuBmG2
 COuNxwripJIQKyA6Thf8sSXJFZA9UijhSBwrXpnMcR6ypaUzzOxQcps3Z8eJMg38cmQGuhcfD
 fMllkO7B4dI6rDtOvQxDV+fbS2sjVP2KkQhwSu3p9ZXyEw+w6MN39qOViA3Ifqv8C8x1Sdrdc
 L0RALRu0Gw4yiKT7JMRgk9ut4rwov7pXlyRZ1rfkEGfP02ljqaF9/XAmYTKChG+GRR+5SiaEz
 d48EiSTi57c5l6qdOvNU70X47YFsOdui8hpOI9TLyftDHnZiIXmI8jROdNmHDoKsuYNYu9UcX
 CO2pXvD/JW7osug1ZYWTOkUejq5OYaFIM8L3mOOIrKlUsugmznzr7XBFmgUlW/rMLK5Gzswzk
 mJ/eZiFecYu/f4/j+xpry4a+KqDd2+rKr2c74mVEI9kRbSs1HwtfgAcwmtQLBOqKdPLnVtqg+
 RO7e7LYtNkiBwrxl/if5mQg1zlpm7kaUDNHBFqIhsVyZVg9O992IBPRbPXDC1AwRbQFEvlyFU
 BAcFm7Kvjf8rgERjOqffBYQXVj5dZHwSy8ujbr3YZ+thioVpqo+rB74Nv4Vs0/f2sR7X2YKVj
 wQaFcR5mrgnilsjDkuv9QVfrQgVP2LAEXX1Vfsv0FNKwym9t2Q7fiPIHqpKtnemTPvEBi9fyR
 kZ3XTXu4fH9mQOZ3oNJNScmBC/0Yuo35RoiKA/qjU9gJWLibej0MOSxFBIKThJ3s8hUkM8Ere
 rE7G27z9in9OxXVqJTt0kWwGlu10LoH+qqxyeI938CKaNJmdvSxv7ykpRPoFSCIP0OlXDlAHt
 eienSL+D2ooNGfPWA5KrAgwlVaUy/nSptq8P/e9P6w1ol0H8QdzczIEvZ6JfGuoXddM51YqHv
 nMzz5BmMnHJkz/OfMj4/4+DM1ulPPpxnCrxLs26kUmmI1OhY6mCCE4R+4bhzM1FvXMOTyunn8
 QkCdJ9Y/G8JqfXj8tesxf92NwvENDv6mhOV0RSf98VtqsUmIi3dms+QK+KG677/Vi0Ek6hYeb
 BRMjlCxgi/FgI+p/O9gEUiJ0dGr9ueXkzv+FCDVLvFNnhxjIQRuQzA0R4StqTiQ76OWbfJVz4
 7adVWpUG2WVWdgWoBEq+I7CaWA47VYDjFdNa+l3+4R8IYf6QAbjLbLvboCeemI+KB2CAMfDgZ
 5DdopKTOdn2br6KqmGwNfPDT9O3xyF+HS5PB6PxI8OCiZsPBMcLEDRciU1ex0wV08TpI4bZwY
 IaoY1BCQBNWrONyhmPL7up5qTz+81UbteWvB9ZomFC/31BujEyv9Q1lXjpr9wl+9G4XBL+yeX
 OnQOk+0tEHN9YnncF/o8hAXvHO7lZhF/wgrbTicQFPEIpT6neqU2vcVbdXAWPIwLUAdWOqjvw
 9BN10uaRMarefg/k/Pl0G4Cq/CXJqgzZ6DswyNNhvczS536E+Ga2APU6fe3m7EaQCtxWGjQoi
 JQMDvIWQSsP3qzU2LBV5oJ06uDphmj7JHgnshnsjsYmG9K5LYZ61uSDZeGxIULnnyxNCxD7TK
 zqjQDKPX+gCA+e4yH/zYupH/4quMMsFlVeCmGkXBfFlwv9Js

>> Use an additional label so that a bit of exception handling can be bett=
er
>> reused at the end of this function implementation.
>>
>> This issue was detected by using the Coccinelle software.
=E2=80=A6
>> +++ b/kernel/bpf/states.c
=E2=80=A6
>> @@ -1588,4 +1583,9 @@ int bpf_is_state_visited(struct bpf_verifier_env =
*env, int insn_idx)
>>         bpf_clear_jmp_history(cur);
>>         list_add(&new_sl->node, head);
>>         return 0;
>> +
>> +free_verifier_state:
>> +       bpf_free_verifier_state(new, false);
>> +       kfree(new_sl);
>> +       return err;
>=20
> This function is full of 'goto's already.
> I prefer to keep the code as-is.

How does such a view fit to a known coding style recommendation?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.1#n526


How do you think about to increase the application of scope-based resource=
 management?

Regards,
Markus
