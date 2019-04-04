Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6298C10F0E
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50B42064A
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9JnNjMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDDPFE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38690 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfDDPFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so1511950pfo.5;
        Thu, 04 Apr 2019 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1b3Z3EZ4wnX9swfnac8AX4F5GdP2NfEZE/Fk+iFdKLU=;
        b=g9JnNjMu3NbDJOSTROjA0ErVZ1UHAOwVIFE7YTMUWCAiLOX162deHMESUeTUnfMpof
         bsngS+lMpbTIHNEr4IIbfEtnqtN2kfoWTtbpSFMM7iX7NxiOfXP6/t6mnodtCcu4Llae
         Al2AsGpzsBf7aFMqgRCtSE41dqg18ACBkwHLE9yB68VugcOsJGtXIdda3yI1M3TiytT8
         UA/xibyuECTK2u6lmzpgtCruIRyhc4sH5eRG4SFjMp3duwpYdbw+exMGn70szLGLzdK1
         OajVnevHv2+p+eNoo1iaAAU9Rm2czqx1/uHONfbUGQo+OYv/I6Jlw2DIiFeHARL9j6Uo
         owQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1b3Z3EZ4wnX9swfnac8AX4F5GdP2NfEZE/Fk+iFdKLU=;
        b=q80T3nluFEaXSNnuAuFI+rIR0HiPaU7ypsTqt1dkJEBfTtse6ldvU5d3D37cDbzHW4
         yAvz0hgE6f5H+F3DyN8gjmbMuJOd7U6xXXEwMqIaraMrHLeGwFiIR8a5v6sXQEtM16Nj
         LLq7PKn6z1h/eB9OEZUvyRqbujMYPygUi29KBApUQeQTpBgYz170lCltF1M47U1/PV+r
         2a9i48eFzEq4mxZn/Y+cgyYzSiO8TfULhVZQvJ8s00qtgUUEgPfhhl4VQBgILZBZ5wng
         47+/lh4EwOvl7s/obHfg+5HhOjGNvWbdyUhe5OxMDnvaLQQtvU+bHYKAkmaXBK4VMUNF
         pvow==
X-Gm-Message-State: APjAAAW2zPgzW4XHo8Vr8c7g8mcSq/WwYlBlCJqES+tFoPO34i+g1Rhh
        Rs0hE6LH1Dpn/c5iyELkzdw=
X-Google-Smtp-Source: APXvYqxA+0L9a7V2QbPp+VWMBjRXjoK4RovvLMFaZKMjvjnURJF2wKjseJwuvkH1Mf4rH5WPO5qvew==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr6325191pgc.238.1554390303273;
        Thu, 04 Apr 2019 08:05:03 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:c5a1:6d6:d92c:c7c1? ([2601:282:800:fd80:c5a1:6d6:d92c:c7c1])
        by smtp.googlemail.com with ESMTPSA id u4sm57570083pgn.12.2019.04.04.08.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:05:01 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Martin Lau <kafai@fb.com>, Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
 <20190404050941.w3fegqpm4kmyx3n5@kafai-mbp.dhcp.thefacebook.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <ecd05a8f-e3c3-0637-0959-879ea3f17572@gmail.com>
Date:   Thu, 4 Apr 2019 09:04:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190404050941.w3fegqpm4kmyx3n5@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/19 11:09 PM, Martin Lau wrote:
> On Wed, Apr 03, 2019 at 08:43:38AM -0700, Peter Oskolkov wrote:
>> This patch adds tests validating that VRF and BPF-LWT
>> encap work together well, as requested by David Ahern.
> LGTM.  David Ahern, please review also.
> 

looking at it last night and hit some problems. Will take another look
today.
