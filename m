Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E42C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E53321019
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCWATM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:19:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:38000 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfCWATL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:19:11 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7UNR-0001Ne-L4; Sat, 23 Mar 2019 01:19:09 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7UNR-0007vK-FX; Sat, 23 Mar 2019 01:19:09 +0100
Subject: Re: [PATCH bpf 1/2] bpf, libbpf: fix version info and add it to
 shared object
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     ast@kernel.org, sdf@google.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190322234755.29306-1-daniel@iogearbox.net>
 <20190322234755.29306-2-daniel@iogearbox.net>
 <20190323000938.GV7431@mini-arch.hsd1.ca.comcast.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d3d082da-e542-036e-c545-6cde254cda3f@iogearbox.net>
Date:   Sat, 23 Mar 2019 01:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190323000938.GV7431@mini-arch.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25396/Fri Mar 22 08:52:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23/2019 01:09 AM, Stanislav Fomichev wrote:
> On 03/23, Daniel Borkmann wrote:
[...]
>> +$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
>> +	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_VERSION) \
> Shouldn't it be -soname,libbpf.so.$(VERSION) ?

The above is generating libbpf.so.0.0.2, and with the below two we generate
symlinks to it. libbpf.so.$(VERSION) would result in libbpf.so.0 otherwise
which we want to be a symlink instead. The workflow I've been following is
similar to fe316723a810 ("tools lib traceevent: Add version for traceevent
shared object").

>> +				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
>> +	@ln -sf $(@F) $(OUTPUT)libbpf.so
>> +	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
>>  
>>  $(OUTPUT)libbpf.a: $(BPF_IN)
>>  	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
>> @@ -192,6 +199,12 @@ check_abi: $(OUTPUT)libbpf.so
>>  		exit 1;							 \
>>  	fi
>>  
>> +define do_install_mkdir
>> +	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
>> +	fi
>> +endef
>> +
>>  define do_install
>>  	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
>>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
>> @@ -200,8 +213,9 @@ define do_install
>>  endef
>>  
>>  install_lib: all_cmd
>> -	$(call QUIET_INSTALL, $(LIB_FILE)) \
>> -		$(call do_install,$(LIB_FILE),$(libdir_SQ))
>> +	$(call QUIET_INSTALL, $(LIB_TARGET)) \
>> +		$(call do_install_mkdir,$(libdir_SQ)); \
>> +		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
>>  
>>  install_headers:
>>  	$(call QUIET_INSTALL, headers) \
>> @@ -219,7 +233,7 @@ config-clean:
>>  
>>  clean:
>>  	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
>> -		*.o *~ *.a *.so .*.d .*.cmd LIBBPF-CFLAGS
>> +		*.o *~ *.a *.so *.so.$(VERSION) .*.d .*.cmd LIBBPF-CFLAGS
> What about libbpf.so.$(LIBBPF_VERSION) ?

That is already cleaned via $(TARGETS), so this is taken care of.

>>  	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
>>  
>>  
>> -- 
>> 2.9.5
>>

